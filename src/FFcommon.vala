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

namespace com.github.robertsanseries.FFmpegCliWrapper {

    public class FFcommon {

        /* Fields */
        protected string input;
        protected string output;
        protected string acodec;
        protected string vcodec;
        protected string format;
        protected bool override_output;

        //private int second_data;

        /* Constructor */
        public FFcommon (FFmpeg ffmpeg) {
            GLib.message ("init class FFcommon");

            this.input = ffmpeg.get_input ();
        	this.output = ffmpeg.get_output ();
        	this.acodec = ffmpeg.get_acodec ();
        	this.vcodec = ffmpeg.get_vcodec ();
        	this.format = ffmpeg.get_format ();
        	this.override_output = ffmpeg.get_override_output ();
        }
    }
}