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

    public class FFprobeStream {

        public enum CodecType {
            VIDEO,
            AUDIO,
        }
    
        /* Fields */
        private string filename;
        private int index;
        private string codec_name;
        private string codec_long_name;
        private string profile;
        private CodecType codec_type;
        //private Fraction codec_time_base;

        private string codec_tag_string;
        private string codec_tag;

        private int width;
        private int height;

        private int has_b_frames;

        private string sample_aspect_ratio;
        private string display_aspect_ratio;

        private string pix_fmt;
        private int level;
        private string chroma_location;
        private int refs;
        private string is_avc;
        private string nal_length_size;
        //private Fraction r_frame_rate;
        //private Fraction avg_frame_rate;
        //private Fraction time_base;

        private long start_pts;
        private double start_time;

        private long duration_ts;
        private double duration;

        private long bit_rate;
        private long max_bit_rate;
        private int bits_per_raw_sample;
        private int bits_per_sample;

        private long nb_frames;

        private string sample_fmt;
        private int sample_rate;
        private int channels;
        private string channel_layout;

        //private FFmpegDisposition disposition;

        private Gee.Map<string, string> tags;

        /* Constructor */
        public FFprobeStream () {
            GLib.message ("init class FFprobeStream");
        }

        public string get_filename () {
          return this.filename;
        }

        public int get_index () {
          return this.index;
        }

        public string get_codec_name () {
          return this.codec_name;
        }

        public string get_codec_long_name () {
          return this.codec_long_name;
        }

        public string get_profile () {
          return this.profile;
        }

        public CodecType get_codec_type () {
          return this.codec_type;
        }

        /*public Fraction get_codec_time_base () {
          return this.codec_time_base;
        }*/

        public string get_codec_tag_string () {
          return this.codec_tag_string;
        }

        public string get_codec_tag () {
          return this.codec_tag;
        }

        public int get_width () {
          return this.width;
        }

        public int get_height () {
          return this.height;
        }

        public int get_has_b_frames () {
          return this.has_b_frames;
        }

        public string get_sample_aspect_ratio () {
          return this.sample_aspect_ratio;
        }

        public string get_display_aspect_ratio () {
          return this.display_aspect_ratio;
        }

        public string get_pix_fmt () {
          return this.pix_fmt;
        }

        public int get_level () {
          return this.level;
        }

        public string get_chroma_location () {
          return this.chroma_location;
        }

        public int get_refs () {
          return this.refs;
        }

        public string get_is_avc () {
          return this.is_avc;
        }

        public string get_nal_length_size () {
          return this.nal_length_size;
        }

        /*public Fraction get_r_frame_rate () {
          return this.r_frame_rate;
        }

        public Fraction get_avg_frame_rate () {
          return this.avg_frame_rate;
        }

        public Fraction get_time_base () {
          return this.time_base;
        }*/

        public long get_start_pts () {
          return this.start_pts;
        }

        public double get_start_time () {
          return this.start_time;
        }

        public long get_duration_ts () {
          return this.duration_ts;
        }

        public double get_duration () {
          return this.duration;
        }

        public long get_bit_rate () {
          return this.bit_rate;
        }

        public long get_max_bit_rate () {
          return this.max_bit_rate;
        }

        public int get_bits_per_raw_sample () {
          return this.bits_per_raw_sample;
        }

        public int get_bits_per_sample () {
          return this.bits_per_sample;
        }

        public long get_nb_frames () {
          return this.nb_frames;
        }

        public string get_sample_fmt () {
          return this.sample_fmt;
        }

        public int get_sample_rate () {
          return this.sample_rate;
        }

        public int get_channels () {
          return this.channels;
        }

        public string get_channel_layout () {
          return this.channel_layout;
        }

        /*public FFmpegDisposition get_disposition () {
          return this.disposition;
        }*/

        public Gee.Map<string, string> get_tags () {
            return this.tags;
        }
    }
}
