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

namespace com.github.robertsanseries.FFmpegCliWrapper {

    public class FFprobeFormat {
    
        /* Fields */
        private string filename;
        private int nb_streams;
        private int nb_programs;

        private string format_name;
        private string format_long_name;
        private double start_time;
        
        private double duration;
        private long size;

        private long bit_rate;
        private int probe_score;

        private Gee.Map<string, string> tags;


        /* Constructor */
        public FFprobeFormat () {
            GLib.message ("init class FFprobeFormat");
        }

        public string get_filename () {
            return this.filename;
        }

        public int get_nb_streams () {
            return this.nb_streams;
        }

        public int get_nb_programs () {
            return this.nb_programs;
        }

        public string get_format_name () {
            return this.format_name;
        }

        public string get_format_long_name () {
            return this.format_long_name;
        }

        public double get_start_time () {
            return this.start_time;
        }

        public double get_duration () {
            return this.duration;
        }

        public long get_size () {
            return this.size;
        }

        public long get_bit_rate () {
            return this.bit_rate;
        }

        public int get_probe_score () {
            return this.probe_score;
        }

        public Gee.Map<string, string> get_tags () {
            return this.tags;
        }
    }
}