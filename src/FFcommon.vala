/*
 * MIT License
 *
* Copyright (c) 2018 Robert San <robertsanseries@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
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