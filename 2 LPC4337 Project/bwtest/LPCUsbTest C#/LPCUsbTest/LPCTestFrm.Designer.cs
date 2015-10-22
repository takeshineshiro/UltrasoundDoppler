namespace LPCTest
{
    partial class LPCTestFrm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.ConButton = new System.Windows.Forms.Button();
            this.StartButton = new System.Windows.Forms.Button();
            this.StopButton = new System.Windows.Forms.Button();
            this.RxBW = new System.Windows.Forms.Label();
            this.TxBW = new System.Windows.Forms.Label();
            this.RxTestRB = new System.Windows.Forms.RadioButton();
            this.TxTestRB = new System.Windows.Forms.RadioButton();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lstResults = new System.Windows.Forms.ListBox();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // ConButton
            // 
            this.ConButton.Location = new System.Drawing.Point(12, 14);
            this.ConButton.Name = "ConButton";
            this.ConButton.Size = new System.Drawing.Size(75, 62);
            this.ConButton.TabIndex = 0;
            this.ConButton.Text = "Find LPC Device";
            this.ConButton.UseVisualStyleBackColor = true;
            this.ConButton.Click += new System.EventHandler(this.ConButton_Click);
            // 
            // StartButton
            // 
            this.StartButton.Enabled = false;
            this.StartButton.Location = new System.Drawing.Point(160, 14);
            this.StartButton.Name = "StartButton";
            this.StartButton.Size = new System.Drawing.Size(75, 62);
            this.StartButton.TabIndex = 3;
            this.StartButton.Text = "Start Test";
            this.StartButton.UseVisualStyleBackColor = true;
            this.StartButton.Click += new System.EventHandler(this.StartButton_Click);
            // 
            // StopButton
            // 
            this.StopButton.Enabled = false;
            this.StopButton.Location = new System.Drawing.Point(308, 14);
            this.StopButton.Name = "StopButton";
            this.StopButton.Size = new System.Drawing.Size(75, 62);
            this.StopButton.TabIndex = 4;
            this.StopButton.Text = "Stop Test";
            this.StopButton.UseVisualStyleBackColor = true;
            this.StopButton.Click += new System.EventHandler(this.StopButton_Click);
            // 
            // RxBW
            // 
            this.RxBW.AutoSize = true;
            this.RxBW.Location = new System.Drawing.Point(227, 26);
            this.RxBW.Name = "RxBW";
            this.RxBW.Size = new System.Drawing.Size(31, 13);
            this.RxBW.TabIndex = 6;
            this.RxBW.Text = "1024";
            // 
            // TxBW
            // 
            this.TxBW.AutoSize = true;
            this.TxBW.Location = new System.Drawing.Point(227, 65);
            this.TxBW.Name = "TxBW";
            this.TxBW.Size = new System.Drawing.Size(31, 13);
            this.TxBW.TabIndex = 7;
            this.TxBW.Text = "1024";
            // 
            // RxTestRB
            // 
            this.RxTestRB.AutoSize = true;
            this.RxTestRB.Location = new System.Drawing.Point(19, 24);
            this.RxTestRB.Name = "RxTestRB";
            this.RxTestRB.Size = new System.Drawing.Size(154, 17);
            this.RxTestRB.TabIndex = 8;
            this.RxTestRB.TabStop = true;
            this.RxTestRB.Text = "USB Rx Bandwidth (bits/s):";
            this.RxTestRB.UseVisualStyleBackColor = true;
            // 
            // TxTestRB
            // 
            this.TxTestRB.AutoSize = true;
            this.TxTestRB.Location = new System.Drawing.Point(19, 63);
            this.TxTestRB.Name = "TxTestRB";
            this.TxTestRB.Size = new System.Drawing.Size(153, 17);
            this.TxTestRB.TabIndex = 9;
            this.TxTestRB.TabStop = true;
            this.TxTestRB.Text = "USB Tx Bandwidth (bits/s):";
            this.TxTestRB.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.TxTestRB);
            this.groupBox1.Controls.Add(this.RxTestRB);
            this.groupBox1.Controls.Add(this.TxBW);
            this.groupBox1.Controls.Add(this.RxBW);
            this.groupBox1.Location = new System.Drawing.Point(13, 82);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(369, 110);
            this.groupBox1.TabIndex = 10;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Test";
            // 
            // lstResults
            // 
            this.lstResults.FormattingEnabled = true;
            this.lstResults.Location = new System.Drawing.Point(15, 207);
            this.lstResults.Name = "lstResults";
            this.lstResults.Size = new System.Drawing.Size(367, 134);
            this.lstResults.TabIndex = 11;
            // 
            // LPCTestFrm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(406, 361);
            this.Controls.Add(this.lstResults);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.StopButton);
            this.Controls.Add(this.StartButton);
            this.Controls.Add(this.ConButton);
            this.Name = "LPCTestFrm";
            this.Text = "LPCDisplayForm";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.LPCDisp_close);
            this.Load += new System.EventHandler(this.LPCDisp_open);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button ConButton;
        private System.Windows.Forms.Button StartButton;
        private System.Windows.Forms.Button StopButton;
        private System.Windows.Forms.Label RxBW;
        private System.Windows.Forms.Label TxBW;
        private System.Windows.Forms.RadioButton RxTestRB;
        private System.Windows.Forms.RadioButton TxTestRB;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ListBox lstResults;
    }
}

