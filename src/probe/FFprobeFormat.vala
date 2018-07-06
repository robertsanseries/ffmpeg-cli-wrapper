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

namespace com.github.robertsanseries.FFmpegCliWrapper.Probe {

    public class FFprobeFormat {
    
        /* Fields */
        private string _filename;
        private int _nb_streams;
        private int _nb_programs;
        private string _format_name;
        private string _format_long_name;
        private double _start_time;
        private double _duration;
        private long _size;
        private long _bit_rate;
        private int _probe_score;
        private Gee.Map<string, string> _tags;

        /* Constructor */
        public FFprobeFormat () {
            GLib.message ("init class FFprobeFormat");
        }

        /* Propriedade */
        public string filename {
            get { return  _filename ; }
            set { _filename = value ; }
        }

        public int nb_streams {
            get { return  _nb_streams ; }
            set { _nb_streams = value ; }
        }

        public int nb_programs {
            get { return  _nb_programs ; }
            set { _nb_programs = value ; }
        }

        public string format_name {
            get { return  _format_name ; }
            set { _format_name = value ; }
        }

        public string format_long_name {
            get { return  _format_long_name ; }
            set { _format_long_name = value ; }
        }

        public double start_time {
            get { return  _start_time ; }
            set { _start_time = value ; }
        }

        public double duration {
            get { return  _duration ; }
            set { _duration = value ; }
        }

        public long size {
            get { return  _size ; }
            set { _size = value ; }
        }

        public long bit_rate {
            get { return  _bit_rate ; }
            set { _bit_rate = value ; }
        }

        public int probe_score {
            get { return  _probe_score ; }
            set { _probe_score = value ; }
        }

        public Gee.Map<string, string> tags {
            get { return _tags ; }
            set { _tags = value ; }
        }
    }
}