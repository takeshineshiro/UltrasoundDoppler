using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Timers;
using System.Runtime.InteropServices;
using System.Threading;
namespace LPCTest
{
    public partial class LPCTestFrm : Form
    {
        //  This GUID must match the GUID in the device's INF file.
        //  To create a GUID in Visual Studio, click Tools > Create GUID.

        private const String LPCDISPLAY_GUID_STRING = "{a01674b4-c5f6-485c-af94-3271701d57b4}";

        private IntPtr deviceNotificationHandle;
        private Boolean m_DeviceDetected = false;
        private UInt32 m_bytesRx = 0;
        private UInt32 m_bytesTx = 0;
        private Boolean m_msgToggle = false;

        private static System.Timers.Timer m_ResTimer;
        private Byte[] m_frameBuf;
        private DeviceManagement m_DeviceManagement = new DeviceManagement();
        private String m_DevicePathName;
        private WinUsbDevice m_WinUsbDevice = new WinUsbDevice();
        internal LPCTestFrm m_form;
        private Boolean m_stopTest = false;
        private Object thisLock = new Object();
        // worker thread
        Thread[] m_txThreads;
        ThreadWaiter sendWaiter = new ThreadWaiter(100);
        Semaphore readSem = new Semaphore( 1, 1);


        ///  <summary>
        ///  Define a class of delegates with the same parameters as 
        ///  WinUsbDevice.ReadViaBulkTransfer and WinUsbDevice.ReadViaInterruptTransfer.
        ///  Used for asynchronous reads from the device.
        ///  </summary>

        private delegate void ReadFromDeviceDelegate
            (ref Byte pipeID,
            UInt32 bufferLength,
            ref Byte[] buffer,
            ref UInt32 lengthTransferred,
            ref Boolean success);

        ///  <summary>
        ///  Define a delegate with the same parameters as AccessForm.
        ///  Used in accessing the application's form from a different thread.
        ///  </summary>

        private delegate void MarshalToForm(String action, String textToAdd);
        private delegate void TimerDelegate();

        public LPCTestFrm()
        {
            InitializeComponent();
            StartButton.Enabled = false;
        }

         private void ComputeRes()
         {
             try
             {
                 if (m_DeviceDetected)
                 {
                     lock (thisLock)
                     {

                         if (m_stopTest == false)
                         {
                             RxBW.Text = "" + (m_bytesRx ) + "bps" + ((m_msgToggle)? " - " : " | ");
                             TxBW.Text = "" + (m_bytesTx ) + "bps" + ((m_msgToggle) ? " - " : " | ");
                             m_bytesRx = m_bytesTx = 0;
                             m_msgToggle = !m_msgToggle;
                         }
                     }
                     
                 }

             }
             catch (Exception ex)
             {
                 throw ex;
             }
         }

         private void ResTimerMethod(object source, ElapsedEventArgs e)
         {
             TimerDelegate msgDelegate = null;

             try
             {
                 //  The AccessForm routine contains the code that accesses the form.
                 msgDelegate = new TimerDelegate(ComputeRes);

                 //  send new fb.
                 base.BeginInvoke(msgDelegate, null);
             }
             catch (Exception ex)
             {
                 throw ex;
             }

         }

         private void InitVideoTimer()
         {
             // allocate frame buffer
             m_frameBuf = new Byte[160 * 1024];

             for (int i = 0; i < m_frameBuf.Length / 64; i++)
             {
                 m_frameBuf[i * 64 + 0] = (Byte)(i >> 8);
                 m_frameBuf[i * 64 + 1] = (Byte)(i);
             }
             // Create a timer with a 8 second interval.
             m_ResTimer = new System.Timers.Timer(8000);

             // Hook up the Elapsed event for the timer.
             m_ResTimer.Elapsed += new ElapsedEventHandler(ResTimerMethod);

             // Set the Interval to 8 seconds.
             m_ResTimer.Interval = 8000;

             GC.KeepAlive(m_ResTimer);
         }
        ///  <summary>
        ///  Performs various application-specific functions that
        ///  involve accessing the application's form.
        ///  </summary>
        ///  
        ///  <param name="action"> A String that names the action to perform on the form. </param>
        ///  <param name="formText"> Text to display on the form or an empty String. </param>
        ///  
        /// <remarks>
        ///  In asynchronous calls to WinUsb_ReadPipe, the callback function 
        ///  uses this routine to access the application's form, which runs in 
        ///  a different thread.
        /// </remarks>
        /// 
        private void AccessForm(String action, String formText)
        {
            try
            {
                //  Select an action to perform on the form:

                switch (action)
                {
                    case "AddItemToListBox":

                        lstResults.Items.Add(formText);
                        break;
                    case "ScrollToBottomOfListBox":

                        lstResults.SelectedIndex = lstResults.Items.Count - 1;

                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        ///  <summary>
        ///  Enables accessing a form from another thread 
        ///  </summary>
        ///  
        ///  <param name="action"> A String that names the action to perform on the form. </param>
        ///  <param name="textToDisplay"> Text that the form displays or uses for 
        ///  another purpose. Actions that don't use text ignore this parameter. </param>

        private void MyMarshalToForm(String action, String textToDisplay)
        {
            object[] args = { action, textToDisplay };
            MarshalToForm MarshalToFormDelegate = null;

            try
            {
                //  The AccessForm routine contains the code that accesses the form.

                MarshalToFormDelegate = new MarshalToForm(AccessForm);

                //  Execute AccessForm, passing the parameters in args.

                base.Invoke(MarshalToFormDelegate, args);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        ///  <summary>
        ///  Display the device's speed in the status lable.
        ///  </summary>
        ///  
        ///  <remarks>
        ///  Precondition: device speed was obtained by calling WinUsb_QueryDeviceInformation
        ///  and stored in myDevInfo. 
        ///  </remarks >

        private void DisplayDeviceSpeed()
        {
            String speed = "";

            m_WinUsbDevice.QueryDeviceSpeed();

            try
            {
                switch (m_WinUsbDevice.myDevInfo.devicespeed)
                {
                    case 1:
                        speed = "low";
                        break;
                    case 2:
                        speed = "full";
                        break;
                    case 3:
                        speed = "high";
                        break;
                }

                lstResults.Items.Add("Device speed = " + speed);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        ///  <summary>
        ///  If a device with the specified device interface GUID hasn't been previously detected,
        ///  look for it. If found, open a handle to the device.
        ///  </summary>
        ///  
        ///  <returns>
        ///  True if the device is detected, False if not detected.
        ///  </returns>

        private Boolean FindMyDevice()
        {
            Boolean deviceFound;
            String devicePathName = "";
            Boolean success;

            try
            {
                if (!(m_DeviceDetected))
                {

                    //  Convert the device interface GUID String to a GUID object: 

                    System.Guid winUsbDemoGuid =
                        new System.Guid(LPCDISPLAY_GUID_STRING);

                    // Fill an array with the device path names of all attached devices with matching GUIDs.

                    deviceFound = m_DeviceManagement.FindDeviceFromGuid
                        (winUsbDemoGuid,
                        ref devicePathName);

                    if (deviceFound == true)
                    {
                        success = m_WinUsbDevice.GetDeviceHandle(devicePathName);

                        if (success)
                        {
                            lstResults.Items.Add("Device detected:");

                            m_DeviceDetected = true;
                            StartButton.Enabled = true;
 
                            // Save DevicePathName so OnDeviceChange() knows which name is my device.

                            m_DevicePathName = devicePathName;
                        }
                        else
                        {
                            // There was a problem in retrieving the information.
                            m_DeviceDetected = false;
                            m_WinUsbDevice.CloseDeviceHandle();
                            StartButton.Enabled = false;
                        }
                    }

                    if (m_DeviceDetected)
                    {

                        // The device was detected.
                        // Register to receive notifications if the device is removed or attached.

                        success = m_DeviceManagement.RegisterForDeviceNotifications(
                            m_DevicePathName,
                            m_form.Handle,
                            winUsbDemoGuid,
                            ref deviceNotificationHandle);

                        if (success)
                        {
                            // init the device
                            m_WinUsbDevice.InitializeDevice();

                            //allocate the tx threads 
                            if (m_txThreads == null)
                                m_txThreads = new Thread[m_WinUsbDevice.myDevInfo.outPipes];
                            //Commented out due to unreliable response from WinUsb_QueryDeviceInformation.                            
                            DisplayDeviceSpeed();
                        }
                    }
                    else
                    {
                        lstResults.Items.Add("Device not found.");
                    }
                }
                else
                {
                    lstResults.Items.Add("Device detected.");
                }


                return m_DeviceDetected;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        ///  <summary>
        ///  Retrieves received data from a bulk endpoint.
        ///  This routine is called automatically when m_WinUsbDevice.ReadViaBulkTransfer
        ///  returns. The routine calls several marshaling routines to access the main form.       
        ///  </summary>
        ///  
        ///  <param name="ar"> An object containing status information about the 
        ///  asynchronous operation.</param>
        ///  
        private void GetReceivedBulkData(IAsyncResult ar)
        {
            UInt32 bytesRead = 0;
            Byte pipeId = 0;
            Byte[] receivedDataBuffer;
            Boolean success = false;

            try
            {
                receivedDataBuffer = null;

                // Define a delegate using the IAsyncResult object.

                ReadFromDeviceDelegate deleg =
                    ((ReadFromDeviceDelegate)(ar.AsyncState));

                // Get the IAsyncResult object and the values of other paramaters that the
                // BeginInvoke method passed ByRef.

                deleg.EndInvoke
                    (ref pipeId,
                    ref receivedDataBuffer,
                    ref bytesRead,
                    ref success, ar);

                // protect the follow data using mutex
                readSem.WaitOne();
                // update the total received byte count.
                if ((ar.IsCompleted && success))
                {
                    m_bytesRx += bytesRead;
                }
                else
                {
                    MyMarshalToForm("AddItemToTextBox", "The attempt to read bulk data has failed.");
                    m_DeviceDetected = false;
                }
                // release mutex
                readSem.Release();
                // Enable requesting another transfer.
                if (m_stopTest == false)
                    ReadDataViaBulkTransfer(pipeId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ConButton_Click(object sender, EventArgs e)
        {
            try
            {
                FindMyDevice();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        ///  <summary>
        ///  Called when a WM_DEVICECHANGE message has arrived,
        ///  indicating that a device has been attached or removed.
        ///  </summary>
        ///  
        ///  <param name="m"> A message with information about the device. </param>

        internal void OnDeviceChange(Message m)
        {
            try
            {
                if ((m.WParam.ToInt32() == DeviceManagement.DBT_DEVICEARRIVAL))
                {

                    //  If WParam contains DBT_DEVICEARRIVAL, a device has been attached.
                    //  Find out if it's the device we're communicating with.

                    if (m_DeviceManagement.DeviceNameMatch(m, m_DevicePathName))
                    {
                        lstResults.Items.Add("My device attached.");
                        FindMyDevice();
                    }

                }
                else if ((m.WParam.ToInt32() ==
                    DeviceManagement.DBT_DEVICEREMOVECOMPLETE))
                {
                    //  If WParam contains DBT_DEVICEREMOVAL, a device has been removed.
                    //  Find out if it's the device we're communicating with.

                    if (m_DeviceManagement.DeviceNameMatch(m, m_DevicePathName))
                    {

                        //  Set m_DeviceDetected False so on the next data-transfer attempt,
                        //  FindMyDevice() will be called to look for the device 
                        //  and get a new handle.
                        m_form.m_DeviceDetected = false;
                        lstResults.Items.Add("My device removed.");
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        ///  <summary>
        ///  Initiates a read operation from a bulk IN endpoint.
        ///  To enable reading without blocking the main thread, uses an asynchronous delegate.
        ///  </summary>
        ///  
        ///  <remarks>
        ///  To enable reading more than 64 bytes (with device firmware support), increase bytesToRead.
        ///  </remarks> 

        private void ReadDataViaBulkTransfer(Byte pipeID)
        {

            IAsyncResult ar = null;
            UInt32 bytesRead = 0;
            UInt32 bytesToRead = Convert.ToUInt32(m_frameBuf.Length);
            Boolean success = false;

            //  Define a delegate for the ReadViaBulkTransfer method of WinUsbDevice.

            ReadFromDeviceDelegate MyReadFromDeviceDelegate =
                new ReadFromDeviceDelegate(m_WinUsbDevice.ReadViaBulkTransfer);

            try
            {
                //  The BeginInvoke method calls m_WinUsbDevice.ReadViaBulkTransfer to attempt 
                //  to read data. The method has the same parameters as ReadViaBulkTransfer,
                //  plus two additional parameters:
                //  GetReceivedBulkData is the callback routine that executes when 
                //  ReadViaBulkTransfer returns.
                //  MyReadFromDeviceDelegate is the asynchronous delegate object.

                ar = MyReadFromDeviceDelegate.BeginInvoke
                    (ref pipeID,
                    bytesToRead,
                    ref m_frameBuf,
                    ref bytesRead,
                    ref success,
                    new AsyncCallback(GetReceivedBulkData),
                    MyReadFromDeviceDelegate);

                if (success)
                {
                    //m_bytesRx += bytesRead;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        ///  <summary>
        ///  Initiates sending data via a bulk transfer, then receiving data via a bulk transfer.
        ///  </summary>

        private bool SendViaBulkTransfers(Byte bulkOutPipe)
        {
            try
            {
                Boolean success;
                UInt32 bytesToSend;


                bytesToSend = Convert.ToUInt32(m_frameBuf.Length); 

                // If the device hasn't been detected, was removed, or timed out on a previous attempt
                // to access it, look for the device.
                if (m_DeviceDetected)
                {
                        success = m_WinUsbDevice.SendViaBulkTransfer
                            (bulkOutPipe,
                            ref m_frameBuf,
                            bytesToSend);

                        if (success)
                        {
                            m_bytesTx += bytesToSend;
                            //lstResults.Items.Add("Bytes Transfered ");
                        }
                        else
                        {
                            return false;
                        }
                    
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        // Worker thread function.
        // Called indirectly from btnStartThread_Click
        private void WorkerThreadFunction(object bulkOutPipe)
        {
            while (m_stopTest == false)
            {
                SendViaBulkTransfers(System.Convert.ToByte(bulkOutPipe));
            }
            sendWaiter.RemoveThread();
        }


        private void LPCDisp_close(object sender, FormClosedEventArgs e)
        {
            try
            {
                m_WinUsbDevice.CloseDeviceHandle();

                m_DeviceManagement.StopReceivingDeviceNotifications
                    (deviceNotificationHandle);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        private void LPCDisp_open(object sender, EventArgs e)
        {
            try
            {
                m_form = this;
                m_WinUsbDevice = new WinUsbDevice();
                InitVideoTimer();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

 
        ///  <summary>
        ///  Overrides WndProc to enable checking for and handling
        ///  WM_DEVICECHANGE messages.
        ///  </summary>
        ///  
        ///  <param name="m"> A Windows message.
        ///  </param> 
        ///  
        protected override void WndProc(ref Message m)
        {
            try
            {
                // The OnDeviceChange routine processes WM_DEVICECHANGE messages.

                if (m.Msg == DeviceManagement.WM_DEVICECHANGE)
                {
                    OnDeviceChange(m);
                }
                // Let the base form process the message.

                base.WndProc(ref m);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void StartButton_Click(object sender, EventArgs e)
        {
            m_bytesRx = m_bytesTx = 0;
            m_stopTest = false;
            m_ResTimer.Enabled = true;
            StopButton.Enabled = true;
            StartButton.Enabled = false;

            if (RxTestRB.Checked)
            {
                for (int i = 0; i < m_WinUsbDevice.myDevInfo.inPipes; i++)
                {
                    ReadDataViaBulkTransfer(m_WinUsbDevice.myDevInfo.bulkInPipe[i]);
                }
            }
            if (TxTestRB.Checked)
            {
                for (int i = 0; i < m_WinUsbDevice.myDevInfo.outPipes; i++)
                {
                    // create worker thread instance
                    m_txThreads[i] = new Thread(this.WorkerThreadFunction);
                    sendWaiter.AddThreads(1);

                    m_txThreads[i].Name = "USBTx Thread for EP: " + m_WinUsbDevice.myDevInfo.bulkOutPipe[i];   // looks nice in Output window
                    m_txThreads[i].Start(m_WinUsbDevice.myDevInfo.bulkOutPipe[i]);
                }

            }
                       
        }

        private void StopButton_Click(object sender, EventArgs e)
        {
            m_stopTest = true;
            m_ResTimer.Enabled = false;
            StopButton.Enabled = false;
            if (TxTestRB.Checked)
                sendWaiter.Wait();

            StartButton.Enabled = true;

        }
  
  }
}
