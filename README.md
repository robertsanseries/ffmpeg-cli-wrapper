<div align="center">
    <h1>FFmpeg Cli Wrapper</h1>
  <h3 align="center">Vala wrapper around the FFmpeg command line tool</h3>
</div>

<br>

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
 - Force Format

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