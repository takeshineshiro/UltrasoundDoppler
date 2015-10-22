using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LPCTest
{
    class ThreadWaiter 
    { 
        private int _numThreads = 0; 
        private int _spinTime; 
        public ThreadWaiter(int SpinTime) 
        { 
            this._spinTime = SpinTime; 
        } 
        public void AddThreads(int numThreads) 
        { 
            _numThreads += numThreads; 
        } 
        public void RemoveThread() 
        { 
            if (_numThreads > 0) 
            { 
                _numThreads--; 
            } 
        }
        public void Wait() 
        { 
            while (_numThreads != 0) 
            { 
                System.Threading.Thread.Sleep(_spinTime); 
            } 
        } 
    }
}
