<div align="center">
    <h1>FFmpeg Cli Wrapper</h1>
  <h3 align="center">Vala wrapper around the FFmpeg command line tool</h3>
</div>

<div class="center">
  <h1 align="center"> Informations </h1>
</div>

### How this library works:

This library requires a working FFMpeg install. You will need both FFMpeg and FFProbe binaries to use it.

### Installation

You can download FFmpeg Cli Wrapper via Github [Here](https://github.com/olaferlandsen/ffmpeg-php-class/archive/master.zip)

or If you want install via [Vanat](https://vanat.github.io). *recommended


```bash
$ vanat require robertsanseries/ffmpeg-cli-wrapper
```

#### Requirements

* FFmpeg 2.8.14+
* Vala 0.36+

### Documentation

You can find the complete documentation on our [Wiki](""). Or parse the source code.

#### Basic Usage

To use the FFmpeg Cli Wrapper you need to add the namespace:

```vala
	using com.github.robertsanseries.FFmpegCliWrapper;
```

Starting the class:

```vala
	FFmpeg ffmpeg = new FFmpeg ();
```

You may already set some optional values when starting the class:

 - Input
 - Output
 - Override Files
 - Force Format

##### Input & Output.

```vala
	FFmpeg ffmpeg = new FFmpeg (
        "/home/ubuntu/Vídeos/TrumPVenezuela.mkv",
        "/home/ubuntu/Vídeos/TrumPVenezuela.avi"
    );
```

##### Input & Output & Override Files .

```vala
	FFmpeg ffmpeg = new FFmpeg (
        "/home/ubuntu/Vídeos/TrumPVenezuela.mkv",
        "/home/ubuntu/Vídeos/TrumPVenezuela.avi",
        true
    );
```

##### Input & Output & Override Files & Force Format.

```vala
	FFmpeg ffmpeg = new FFmpeg (
        "/home/ubuntu/Vídeos/TrumPVenezuela.mkv",
        "/home/ubuntu/Vídeos/TrumPVenezuela.avi",
        true,
        "avi"
    );
```

You can set the values in two other ways:

##### #1:

```vala
	FFmpeg ffmpeg = new FFmpeg ();
    ffmpeg.set_input ("/home/ubuntu/Vídeos/TrumPVenezuela.mkv");
    ffmpeg.set_output ("/home/ubuntu/Vídeos/TrumPVenezuela.avi");
    ffmpeg.set_format ("avi");
    ffmpeg.set_override_output (true);
```


##### #2:

```vala
	FFmpeg ffmpeg = new FFmpeg ()
    .set_input ("/home/ubuntu/Vídeos/TrumPVenezuela.mkv")
    .set_output ("/home/ubuntu/Vídeos/TrumPVenezuela.avi")
    .set_format ("avi")
    .set_override_output (true);
```

### Test

#### compile

```sh
$	valac src/FFmpeg.vala src/FFcommon.vala src/utils/StringUtil.vala test/FFmpegTest.vala src/exceptions/IllegalArgumentException.vala src/exceptions/IOException.vala -o ffmpeg-cli-wrapper
```

#### execute

```sh
$	./ffmpeg-cli-wrapper
```


### License

This project is licensed under the [MIT license](http://opensource.org/licenses/MIT).








## Video Encoding

FFmpegBuilder builder = new FFmpegBuilder()

  .setInput("input.mp4")     // Filename, or a FFmpegProbeResult
  .overrideOutputFiles(true) // Override the output if it exists

  .addOutput("output.mp4")   // Filename for the destination
    .setFormat("mp4")        // Format is inferred from filename, or can be set
    .setTargetSize(250_000)  // Aim for a 250KB file

    .disableSubtitle()       // No subtiles

    .setAudioChannels(1)         // Mono audio
    .setAudioCodec("aac")        // using the aac codec
    .setAudioSampleRate(48_000)  // at 48KHz
    .setAudioBitRate(32768)      // at 32 kbit/s

    .setVideoCodec("libx264")     // Video using x264
    .setVideoFrameRate(24, 1)     // at 24 frames per second
    .setVideoResolution(640, 480) // at 640x480 resolution


## Get Media Information

FFprobe ffprobe = new FFprobe("/path/to/ffprobe");
FFmpegProbeResult probeResult = ffprobe.probe("input.mp4");

FFmpegFormat format = probeResult.getFormat();
System.out.format("%nFile: '%s' ; Format: '%s' ; Duration: %.3fs", 
	format.filename, 
	format.format_long_name,
	format.duration
);

FFmpegStream stream = probeResult.getStreams().get(0);
System.out.format("%nCodec: '%s' ; Width: %dpx ; Height: %dpx",
	stream.codec_long_name,
	stream.width,
	stream.height
);


## Get progress while encoding
FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);

FFmpegProbeResult in = ffprobe.probe("input.flv");

FFmpegBuilder builder = new FFmpegBuilder()
	.setInput(in) // Or filename
	.addOutput("output.mp4")
	.done();

FFmpegJob job = executor.createJob(builder, new ProgressListener() {

	// Using the FFmpegProbeResult determine the duration of the input
	final double duration_ns = in.getFormat().duration * TimeUnit.SECONDS.toNanos(1);

	@Override
	public void progress(Progress progress) {
		double percentage = progress.out_time_ns / duration_ns;

		// Print out interesting information about the progress
		System.out.println(String.format(
			"[%.0f%%] status:%s frame:%d time:%s ms fps:%.0f speed:%.2fx",
			percentage * 100,
			progress.status,
			progress.frame,
			FFmpegUtils.toTimecode(progress.out_time_ns, TimeUnit.NANOSECONDS),
			progress.fps.doubleValue(),
			progress.speed
		));
	}
});

job.run();