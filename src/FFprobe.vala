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
using com.github.robertsanseries.FFmpegCliWrapper.Probe;

namespace com.github.robertsanseries.FFmpegCliWrapper {

    public errordomain MyError {
            INVALID_FORMAT
        }

    public class FFprobe {

        /* Fields */
        private FFprobeError error;
        private FFprobeFormat format;
        private Gee.HashSet<FFprobeStream> streams;
       
        /* Constructor */
        public FFprobe (string input) {

            try {
                GLib.message ("init class FFprobe");

                string standard_output;
                string standard_error;
                int exit_status;

                Process.spawn_command_line_sync (
                    "ffprobe -hide_banner -show_format -show_error -show_streams -show_programs -show_chapters -show_private_data -print_format json ".concat(input), 
                    out standard_output, out standard_error, out exit_status
                );

                if (exit_status != 0) {
                    throw new IOException.MESSAGE (standard_error);
                }

                this.error = new FFprobeError ();
                this.format = new FFprobeFormat ();
                this.streams = new Gee.HashSet<FFprobeStream> ();

                this.process_json (standard_output);
            } catch (Error e) {
                throw new IOException.MESSAGE (e.message);
            }
        }

        private void process_json (string json) throws Error {
            var parser = new Json.Parser();
            parser.load_from_data (json);

            Json.Node node = parser.get_root();

            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "programs":
                        Json.Node item = obj.get_member (name);
                        this.process_programs (item);
                        break;

                    case "streams":
                        Json.Node item = obj.get_member (name);
                        this.process_streams (item);
                        break;

                    case "chapters":
                        Json.Node item = obj.get_member (name);
                        this.process_chapters (item);
                        break;
                    
                    case "format":
                        Json.Node item = obj.get_member (name);
                        this.process_format (item);
                        break;
                }
            }
        }

        private void process_programs (Json.Node node) throws Error {
            this.validate_node_type_array (node);
        }

        private void process_streams (Json.Node node) throws Error {
            this.validate_node_type_array (node);

            Json.Array array = node.get_array ();
            int i = 1;

            foreach (Json.Node item in array.get_elements ()) {
                this.process_streams_array (item, i);
                i++;
            }
        }

        public void process_streams_array (Json.Node node, uint number) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            FFprobeStream ffprobe_stream = new FFprobeStream();
            ffprobe_stream.index                = int.parse (obj.get_string_member ("index"));
            ffprobe_stream.codec_name           = obj.get_string_member ("codec_name");
            ffprobe_stream.codec_long_name      = obj.get_string_member ("codec_long_name");
            ffprobe_stream.profile              = obj.get_string_member ("profile");
            //ffprobe_stream.codec_type           = obj.get_string_member ("codec_type");
            //ffprobe_stream.codec_time_base      = obj.get_string_member ("codec_time_base");
            ffprobe_stream.codec_tag_string     = obj.get_string_member ("codec_tag_string");
            ffprobe_stream.codec_tag            = obj.get_string_member ("codec_tag");
            ffprobe_stream.width                = int.parse (obj.get_string_member ("width"));
            ffprobe_stream.height               = int.parse (obj.get_string_member ("height"));
            //ffprobe_stream.coded_width          = obj.get_string_member ("coded_width");
            //ffprobe_stream.coded_height         = obj.get_string_member ("coded_height");
            ffprobe_stream.has_b_frames         = int.parse (obj.get_string_member ("has_b_frames"));
            ffprobe_stream.sample_aspect_ratio  = obj.get_string_member ("sample_aspect_ratio");
            ffprobe_stream.display_aspect_ratio = obj.get_string_member ("display_aspect_ratio");
            ffprobe_stream.pix_fmt              = obj.get_string_member ("pix_fmt");
            ffprobe_stream.level                = int.parse (obj.get_string_member ("level"));
            ffprobe_stream.chroma_location      = obj.get_string_member ("chroma_location");
            ffprobe_stream.refs                 = int.parse (obj.get_string_member ("refs"));
            ffprobe_stream.is_avc               = obj.get_string_member ("is_avc");
            ffprobe_stream.nal_length_size      = obj.get_string_member ("nal_length_size");
            //ffprobe_stream.r_frame_rate         = obj.get_string_member ("r_frame_rate");
            //ffprobe_stream.avg_frame_rate       = obj.get_string_member ("avg_frame_rate");
            //ffprobe_stream.time_base            = obj.get_string_member ("time_base");
            ffprobe_stream.start_pts            = long.parse (obj.get_string_member ("start_pts"));
            ffprobe_stream.start_time           = long.parse (obj.get_string_member ("start_time"));
            ffprobe_stream.duration_ts          = long.parse (obj.get_string_member ("duration_ts"));
            ffprobe_stream.duration             = long.parse (obj.get_string_member ("duration"));
            ffprobe_stream.bit_rate             = long.parse (obj.get_string_member ("bit_rate"));
            ffprobe_stream.bits_per_raw_sample  = int.parse (obj.get_string_member ("bits_per_raw_sample"));
            ffprobe_stream.nb_frames            = long.parse (obj.get_string_member ("nb_frames"));

            //ffprobe_stream.disposition  = this.process_disposition (obj.get_member ("disposition"));
            ffprobe_stream.tags         = this.process_streams_tags (obj.get_member ("tags"));

            //this.streams.set(ffprobe_stream);
        }
       
        private void process_disposition (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            string s_default        = obj.get_string_member ("default");
            string dub              = obj.get_string_member ("dub");
            string original         = obj.get_string_member ("original");
            string comment          = obj.get_string_member ("comment");
            string lyrics           = obj.get_string_member ("lyrics");
            string karaoke          = obj.get_string_member ("karaoke");
            string forced           = obj.get_string_member ("forced");
            string hearing_impaired = obj.get_string_member ("hearing_impaired");
            string visual_impaired  = obj.get_string_member ("visual_impaired");
            string clean_effects    = obj.get_string_member ("clean_effects");
            string attached_pic     = obj.get_string_member ("attached_pic");
        }

        private Gee.HashMap<string, string> process_streams_tags (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            Gee.HashMap<string, string> tags = new Gee.HashMap<string, string> ();
            tags.set ("creation_time", obj.get_string_member ("creation_time"));
            tags.set ("language", obj.get_string_member ("language"));
            tags.set ("handler_name", obj.get_string_member ("handler_name"));

            return tags;
        }

        private void process_chapters (Json.Node node) throws Error {
            this.validate_node_type_array (node);
        }

        private void process_format (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            this.format.filename         = obj.get_string_member ("filename");
            this.format.nb_streams       = int.parse (obj.get_string_member ("nb_streams"));
            this.format.nb_programs      = int.parse (obj.get_string_member ("nb_programs"));
            this.format.format_name      = obj.get_string_member ("format_name");
            this.format.format_long_name = obj.get_string_member ("format_long_name");
            this.format.start_time       = int.parse (obj.get_string_member ("start_time"));
            this.format.duration         = int.parse (obj.get_string_member ("duration"));
            this.format.size             = obj.get_string_member ("size").to_int ();
            this.format.bit_rate         = int.parse (obj.get_string_member ("bit_rate"));
            this.format.probe_score      = int.parse (obj.get_string_member ("probe_score"));
            
            this.process_format_tags (obj.get_member ("tags"));
        }

        private void process_format_tags (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            this.format.tags.set ("major_brand", obj.get_string_member ("major_brand"));
            this.format.tags.set ("minor_version", obj.get_string_member ("minor_version"));
            this.format.tags.set ("compatible_brands", obj.get_string_member ("compatible_brands"));
            this.format.tags.set ("encoder", obj.get_string_member ("encoder"));
        }

        private void validate_node_type_value (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.VALUE) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }
        }

        private void validate_node_type_object (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }
        }

        private void validate_node_type_array (Json.Node node) throws Error {
            if (node.get_node_type () != Json.NodeType.ARRAY) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }
        }

        public FFprobeError get_error () {
            return this.error;
        }

        public bool has_error () {
            return this.error != null;
        }

        public FFprobeFormat get_format () {
            return this.format;
        }

        public Gee.HashSet<FFprobeStream> get_streams () {
            return this.streams;
        }
    }
}