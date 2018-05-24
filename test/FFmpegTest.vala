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

using com.github.robertsanseries.FFmpegCliWrapper;

namespace com.github.robertsanseries.FFmpegCliWrapperTest {

	public class FFmpegTest {

        public static void main (string [] args) {
            try {
                FFmpeg ffmpeg = new FFmpeg (
                    "/home/Vídeos/MarcusMiller.mkv",
                    "/home/Vídeos/MarcusMiller.avi",
                    true,
                    "avi"
                );
                GLib.message (ffmpeg.get ());

                FFmpeg ffmpeg1 = new FFmpeg ();
                ffmpeg1.set_input ("/home/Vídeos/MarcusMiller.mkv");
                ffmpeg1.set_output ("/home/Vídeos/MarcusMiller.avi");
                ffmpeg1.set_format ("avi");
                ffmpeg1.set_override_output (true);
                GLib.message (ffmpeg1.get ());

                FFmpeg ffmpeg2 = new FFmpeg ()
                .set_input ("/home/Vídeos/MarcusMiller.mkv")
                .set_output ("/home/Vídeos/MarcusMiller.avi")
                .set_format ("avi")
                .set_override_output (true);
                GLib.message (ffmpeg2.get ());

            } catch (Error e) {
                GLib.message(e.message);
            }
        }
    }
}