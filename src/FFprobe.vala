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

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "index":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string index = obj.get_string_member ("index");
                        break;

                    case "codec_name":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_name = obj.get_string_member ("codec_name");
                        break;

                    case "codec_long_name":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_long_name = obj.get_string_member ("codec_long_name");
                        break;

                    case "profile":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string profile = obj.get_string_member ("profile");
                        break;

                    case "codec_type":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_type = obj.get_string_member ("codec_type");
                        break;

                    case "codec_time_base":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_time_base = obj.get_string_member ("codec_time_base");
                        break;

                    case "codec_tag_string":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_tag_string = obj.get_string_member ("codec_tag_string");
                        break;

                    case "codec_tag":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string codec_tag = obj.get_string_member ("codec_tag");
                        break;

                    case "width":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string width = obj.get_string_member ("width");
                        break;

                    case "height":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string height = obj.get_string_member ("height");
                        break;

                    case "coded_width":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string coded_width = obj.get_string_member ("coded_width");
                        break;

                    case "coded_height":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string coded_height = obj.get_string_member ("coded_height");
                        break;

                    case "has_b_frames":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string has_b_frames = obj.get_string_member ("has_b_frames");
                        break;

                    case "sample_aspect_ratio":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string sample_aspect_ratio = obj.get_string_member ("sample_aspect_ratio");
                        break;

                    case "display_aspect_ratio":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string display_aspect_ratio = obj.get_string_member ("display_aspect_ratio");
                        break;

                    case "pix_fmt":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string pix_fmt = obj.get_string_member ("pix_fmt");
                        break;

                    case "level":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string level = obj.get_string_member ("level");
                        break;

                    case "chroma_location":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string chroma_location = obj.get_string_member ("chroma_location");
                        break;

                    case "refs":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string refs = obj.get_string_member ("refs");
                        break;

                    case "is_avc":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string is_avc = obj.get_string_member ("is_avc");
                        break;

                    case "nal_length_size":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string nal_length_size = obj.get_string_member ("nal_length_size");
                        break;

                    case "r_frame_rate":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string r_frame_rate = obj.get_string_member ("r_frame_rate");
                        break;

                    case "avg_frame_rate":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string avg_frame_rate = obj.get_string_member ("avg_frame_rate");
                        break;

                    case "time_base":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string time_base = obj.get_string_member ("time_base");
                        break;

                    case "start_pts":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string start_pts = obj.get_string_member ("start_pts");
                        break;

                    case "start_time":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string start_time = obj.get_string_member ("start_time");
                        break;

                    case "duration_ts":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string duration_ts = obj.get_string_member ("duration_ts");
                        break;

                    case "duration":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string duration = obj.get_string_member ("duration");
                        break;

                    case "bit_rate":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string bit_rate = obj.get_string_member ("bit_rate");
                        break;

                    case "bits_per_raw_sample":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string bits_per_raw_sample = obj.get_string_member ("bits_per_raw_sample");
                        break;

                    case "nb_frames":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string nb_frames = obj.get_string_member ("nb_frames");
                        break;

                    case "disposition":
                        Json.Node item = obj.get_member (name);
                        process_disposition (item);
                        break;

                    case "tags":
                        Json.Node item = obj.get_member (name);
                        process_streams_tags (item);
                        break;
                }
            }
        }
       
        private void process_disposition (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "default":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string s_default = obj.get_string_member ("default");
                        break;

                    case "dub":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string dub = obj.get_string_member ("dub");
                        break;

                    case "original":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string original = obj.get_string_member ("original");
                        break;
                    
                    case "comment":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string comment = obj.get_string_member ("comment");
                        break;

                    case "lyrics":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string lyrics = obj.get_string_member ("lyrics");
                        break;

                    case "karaoke":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string karaoke = obj.get_string_member ("karaoke");
                        break;

                    case "forced":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string forced = obj.get_string_member ("forced");
                        break;
                    
                    case "hearing_impaired":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string hearing_impaired = obj.get_string_member ("hearing_impaired");
                        break;

                    case "visual_impaired":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string visual_impaired = obj.get_string_member ("visual_impaired");
                        break;

                    case "clean_effects":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string clean_effects = obj.get_string_member ("clean_effects");
                        break;
                    
                    case "attached_pic":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string attached_pic = obj.get_string_member ("attached_pic");
                        break;
                }
            } 
        }

        private void process_streams_tags (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "creation_time":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string creation_time = obj.get_string_member ("creation_time");
                        break;

                    case "language":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string language = obj.get_string_member ("language");
                        break;

                    case "handler_name":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string handler_name = obj.get_string_member ("handler_name");
                        break;
                }
            } 
        }

        private void process_chapters (Json.Node node) throws Error {
            this.validate_node_type_array (node);
        }

        private void process_format (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "filename":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.filename = obj.get_string_member ("filename");
                        break;

                    case "nb_streams":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.nb_streams = int.parse(obj.get_string_member ("nb_streams"));
                        break;

                    case "nb_programs":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.nb_programs = int.parse(obj.get_string_member ("nb_programs"));
                        break;
                    
                    case "format_name":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.format_name = obj.get_string_member ("format_name");
                        break;

                    case "format_long_name":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.format_long_name = obj.get_string_member ("format_long_name");
                        break;

                    case "start_time":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.start_time = int.parse(obj.get_string_member ("start_time"));
                        break;

                    case "duration":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.duration = int.parse(obj.get_string_member ("duration"));
                        break;
                    
                    case "size":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.size = obj.get_string_member ("size").to_int ();
                        break;

                    case "bit_rate":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.bit_rate = int.parse(obj.get_string_member ("bit_rate"));
                        break;

                    case "probe_score":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        this.format.probe_score = int.parse(obj.get_string_member ("probe_score"));
                        break;

                    case "tags":
                        Json.Node item = obj.get_member (name);
                        this.process_format_tags (item);
                        break;
                }
            }
        }

        private void process_format_tags (Json.Node node) throws Error {
            this.validate_node_type_object (node);

            Json.Object obj = node.get_object ();

            foreach (string name in obj.get_members ()) {
                switch (name) {
                    case "major_brand":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string major_brand = obj.get_string_member ("major_brand");
                        break;

                    case "minor_version":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string minor_version = obj.get_string_member ("minor_version");
                        break;

                    case "compatible_brands":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string compatible_brands = obj.get_string_member ("compatible_brands");
                        break;
                    
                    case "encoder":
                        Json.Node item = obj.get_member (name);
                        this.validate_node_type_value (item);
                        string encoder = obj.get_string_member ("encoder");
                        break;
                } 
            }
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