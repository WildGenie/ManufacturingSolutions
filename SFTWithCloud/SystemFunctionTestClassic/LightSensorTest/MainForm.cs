﻿using DllLog;
//*********************************************************
//
// Copyright (c) Microsoft. All rights reserved.
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
//
//*********************************************************
using System;
using System.Drawing;
using System.Resources;
using System.Windows.Forms;
using Windows.Devices.Sensors;


namespace LightSensorTest
{
    public partial class MainForm : Form
    {
        #region Fields

        private static ResourceManager LocRM;
        System.Timers.Timer _timer = new System.Timers.Timer();


        #endregion // Fields

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the MainForm form class.
        /// </summary>
        public MainForm()
        {
            LocRM = new ResourceManager("win81FactoryTest.AppResources.Res", typeof(win81FactoryTest.TestForm).Assembly);

            InitializeComponent();
            InitializeLightSensor();
            SetString();
            Label.CheckForIllegalCrossThreadCalls = false;
            this.FormBorderStyle = FormBorderStyle.None;//Full screen and no title
            this.WindowState = FormWindowState.Maximized;
        }

        #endregion // Constructor

        /// <summary>
        /// Initialize Accelerometer timer and update Accelerometer every 500ms
        /// </summary>
        private void InitializeLightSensor()
        {
            //Set Timer to update Light 
            _timer.Interval = 500;
            _timer.Elapsed += new System.Timers.ElapsedEventHandler(UpdateLightSensor);
            _timer.Start();

        }

        /// <summary>
        /// Update Light Sensor readings event and update UI
        /// </summary>
        /// <param name="sender">Event sender.</param>
        /// <param name="e">The <see cref="object"/> instance containing the event data.</param>
        private void UpdateLightSensor(object sender, EventArgs e)
        {
            try
            {
                LightSensor light = LightSensor.GetDefault();
                if (light != null)
                {
                    SensorLabel.Text = LocRM.GetString("ALSReading") + ": " + light.GetCurrentReading().IlluminanceInLux.ToString();

                    int colorValue = (int)Math.Min(light.GetCurrentReading().IlluminanceInLux, 255);
                    labelLight.ForeColor = Color.FromArgb(colorValue, colorValue, 0);
                }
                else
                {
                    SensorLabel.Text = LocRM.GetString("NotFound");
                    _timer.Stop();
                }
            }
            catch (Exception ex)
            {
                Log.LogError(ex.ToString());
                _timer.Stop();
            }
        }


        /// <summary>
        /// Control.Click Event handler. Where control is the Pass button
        /// </summary>
        /// <param name="sender">Event sender.</param>
        /// <param name="e">The <see cref="object"/> instance containing the event data.</param>
        private void PassBtn_Click(object sender, EventArgs e)
        {
            Program.ExitApplication(0);
        }


        /// <summary>
        /// Control.Click Event handler. Where control is the Fail button
        /// </summary>
        /// <param name="sender">Event sender.</param>
        /// <param name="e">The <see cref="object"/> instance containing the event data.</param>
        private void FailBtn_Click(object sender, EventArgs e)
        {
            Program.ExitApplication(255);
        }


        /// <summary>
        /// Initializes strings from SystemFunctionTestClass resources
        /// </summary>
        private void SetString()
        {
            Title.Text = LocRM.GetString("ALS") + LocRM.GetString("Test");
            PassBtn.Text = LocRM.GetString("Pass");
            FailBtn.Text = LocRM.GetString("Fail");
        }

    }
}
