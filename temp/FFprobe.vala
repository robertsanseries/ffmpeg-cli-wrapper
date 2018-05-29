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
using com.github.robertsanseries.FFmpegCliWrapper.Utils;

namespace com.github.robertsanseries.FFmpegCliWrapper {

    public class FFprobe {

        // TODO Add Probe Inputstream
        public FFmpegProbeResult probe(String mediaPath, @Nullable String userAgent) throws IOException {
            checkIfFFprobe();

            ImmutableList.Builder<String> args = new ImmutableList.Builder<String>();

            // TODO Add:
            // .add("--show_packets")
            // .add("--show_frames")

            args.add(path).add("-v", "quiet");

            if (userAgent != null) {
              args.add("-user-agent", userAgent);
            }

            args.add("-print_format", "json")
                .add("-show_error")
                .add("-show_format")
                .add("-show_streams")
                .add(mediaPath);

            Process p = runFunc.run(args.build());
            try {
              Reader reader = wrapInReader(p);
              if (LOG.isDebugEnabled()) {
                reader = new LoggingFilterReader(reader, LOG);
              }

              FFmpegProbeResult result = gson.fromJson(reader, FFmpegProbeResult.class);

              throwOnError(p);

              if (result == null) {
                throw new IllegalStateException("Gson returned null, which shouldn't happen :(");
              }

              return result;

            } finally {
              p.destroy();
            }
        }
    }
}