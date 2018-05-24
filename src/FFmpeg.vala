/*
* Copyright (c) 2017 Robert San <robertsanseries@gmail.com>
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*/

using com.github.robertsanseries.FFmpegCliWrapper.Exceptions;
using com.github.robertsanseries.FFmpegCliWrapper.Utils;

namespace com.github.robertsanseries.FFmpegCliWrapper {

    public class FFmpeg {

        /* Fields */
        private const string FFMPEG = "ffmpeg";
        private FFcommon ffcommon;
        private string input;
        private string output;
        private string acodec;
        private string vcodec;
        private string format;
        private bool override_output = false;
        

        /* Constructor */
        public FFmpeg (string? input = null) {
            GLib.message ("init class FFmpeg");
        }

        public FFmpeg set_input (string? input = null) throws IllegalArgumentException {
            GLib.message ("setting the input value");
            
            if (input != null) {
                this.input = input;                
            } else {
                throw new IllegalArgumentException.MESSAGE ("Input value is null");
            }

            return this;
        }

        public FFmpeg set_output (string? output = null) throws IllegalArgumentException {
            GLib.message ("setting the output value");

            if (output != null) {
                this.output = output;
            } else {
                throw new IllegalArgumentException.MESSAGE ("Output value is null");
            }

            return this;
        }

        public FFmpeg set_acodec (string? acodec = null) throws IllegalArgumentException {
            GLib.message ("setting the value of the audio codec");

            if (acodec != null) {
                this.acodec = acodec;
            } else {
                throw new IllegalArgumentException.MESSAGE ("Audio codec value is null");
            }

            return this;
        }

        public FFmpeg set_vcodec (string? vcodec = null) throws IllegalArgumentException {
            GLib.message ("setting the value of the video codec");

            if (vcodec != null) {
                this.vcodec = vcodec;
            } else {
                throw new IllegalArgumentException.MESSAGE ("Video codec value is null");
            }

            return this;
        }

        public FFmpeg set_format (string? format = null) throws IllegalArgumentException {
            GLib.message ("forcing Output Format");

            if (format != null) {
                this.format = format;
            } else {
                throw new IllegalArgumentException.MESSAGE ("Force Format value is null");
            }

            return this;
        }

        public FFmpeg set_override_output (bool override_output = false) throws IllegalArgumentException {
            GLib.message ("setting whether to overwrite the output files");
            this.override_output = override_output;
            return this;
        }

        public string get () throws IllegalArgumentException {
            string command = command_mount ();

            if (this.ffcommon != null) {
                this.build ();
            }

            GLib.message ("returning the command that will be executed");
            return command;
        }

        private string command_mount () throws IllegalArgumentException {
            GLib.message ("setting up the command that will be executed");

            GenericArray<string> array = new GenericArray<string> ();
            string command = StringUtil.EMPTY;

            array.add (FFMPEG);

            if (this.override_output) {
                array.add ("-y");    
            }
            
            array.add ("-i");
            
            if (! StringUtil.is_empty(this.input)) {
                array.add (this.input);
            } else {
                throw new IllegalArgumentException.MESSAGE ("Input can not be null when mounting the command");
            }
            
            if (! StringUtil.is_empty(this.format)) {
                array.add ("-f");
                array.add (this.format);
            }
            
            if (! StringUtil.is_empty(this.output)) {
                array.add (this.output);    
            }

            array.foreach ((str) => {
                command += str + StringUtil.SPACE;
            });

            return command;
        }

        private FFcommon build () {
            this.ffcommon = new FFcommon (this);
            return this.ffcommon;
        }        

        public string get_input () {
            return this.input;
        }
        
        public string get_output () {
            return this.output;
        }
        
        public string get_acodec () {
            return this.acodec;
        }
        
        public string get_vcodec () {
            return this.vcodec;
        }
        
        public string get_format () {
            return this.format;
        }
        
        public bool get_override_output () {
            return this.override_output;
        }
    }
}