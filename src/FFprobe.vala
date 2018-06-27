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
        private GLib.List<FFprobeStream> streams;

        
        
        /* Constructor */
        public FFprobe (string input) {
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

            //process_json(standard_output);

        }

        private void process_json (string json) {
            var parser = new Json.Parser();
            parser.load_from_data (json);

            // Get the root node:
           // var node = parser.get_root ();

           /* if (node.get_node_type () != Json.NodeType.OBJECT) {
                throw new MyError.INVALID_FORMAT ("Unexpected element type %s", node.type_name ());
            }

            unowned Json.Object obj = node.get_object ();

            foreach (unowned string name in obj.get_members ()) {
                switch (name) {
                case "format":
                    unowned Json.Node item = obj.get_member (name);
                    message("foi");
                    //process_good (item);
                    break;

                /*case "bad":
                    unowned Json.Node item = obj.get_member (name);
                    process_bad (item);
                    break;* /

                default:
                    throw new MyError.INVALID_FORMAT ("Unexpected element '%s'", name);
                }
            }*/
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

        /*public GLib.List<FFprobeStream>? get_streams () {
            return this.streams;
        }*/
    }
}