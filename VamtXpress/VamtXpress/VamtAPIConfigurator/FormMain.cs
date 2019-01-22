﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using Utility;
using VamtAPIConfigurator.ViewModels;

namespace VamtAPIConfigurator
{
    public partial class FormMain : Form
    {
        private string currentFilePath = "config.xml";

        public FormMain()
        {
            InitializeComponent();
        }

        public FormMain(string ConfigFilePath)
        {
            this.currentFilePath = ConfigFilePath;
            InitializeComponent();
        }

        private void saveConfig(string url)
        {
            ConfigurationViewModel config = new ConfigurationViewModel()
            {
                VamtApiServicePoint = url
            };

            string xml = XmlUtility.XmlSerialize(config, null, "utf-8");

            using (FileStream stream = new FileStream(this.currentFilePath, FileMode.Create, FileAccess.Write, FileShare.Write))
            {
                using (StreamWriter writer = new StreamWriter(stream, Encoding.UTF8))
                {
                    writer.Write(xml);
                }
            }
        }

        private void loadConfig()
        {
            ConfigurationViewModel config = null;

            string xml = "<configurationItems/>";

            using (FileStream stream = new FileStream(this.currentFilePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                using (StreamReader reader = new StreamReader(stream, Encoding.UTF8))
                {
                    xml = reader.ReadToEnd();
                }
            }

            config = XmlUtility.XmlDeserialize(xml, typeof(ConfigurationViewModel), null, "utf-8") as ConfigurationViewModel;

            this.textBoxUrl.Text = config.VamtApiServicePoint;
        }

        private void buttonSave_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(this.textBoxUrl.Text))
            {
                MessageBox.Show("Url is required!", "Invalid Input", MessageBoxButtons.OK, MessageBoxIcon.Warning);

                return;
            }


            this.saveConfig(this.textBoxUrl.Text);

            string message = String.Format("VAMT API configuration settings successfully saved to \"{0}\"", this.currentFilePath);

            if (MessageBox.Show(message, "Success", MessageBoxButtons.OK, MessageBoxIcon.Information) == System.Windows.Forms.DialogResult.OK)
            {
                this.statusStripLabel1.Text = this.currentFilePath;
            }
        }

        private void FormMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            this.saveConfig(this.textBoxUrl.Text);
        }

        private void FormMain_Load(object sender, EventArgs e)
        {
            this.loadConfig();
        }
    }
}