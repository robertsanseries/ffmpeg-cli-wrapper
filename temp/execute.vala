 */
public class RunProcessFunction implements ProcessFunction {

  static final Logger LOG = LoggerFactory.getLogger(RunProcessFunction.class);

  File workingDirectory;

  @Override
  public Process run(List<String> args) throws IOException {
    Preconditions.checkNotNull(args, "Arguments must not be null");
    Preconditions.checkArgument(!args.isEmpty(), "No arguments specified");

    if (LOG.isInfoEnabled()) {
      LOG.info("{}", Joiner.on(" ").join(args));
    }

    ProcessBuilder builder = new ProcessBuilder(args);
    if (workingDirectory != null) {
      builder.directory(workingDirectory);
    }
    builder.redirectErrorStream(true);
    return builder.start();
  }

  public RunProcessFunction setWorkingDirectory(String workingDirectory) {
    this.workingDirectory = new File(workingDirectory);
    return this;
  }

  public RunProcessFunction setWorkingDirectory(File workingDirectory) {
    this.workingDirectory = workingDirectory;
    return this;
  }
}


        /**
         * Method responsible for conversion suprocess.
         *
         * @see Ciano.Widgets.Properties
         * @see Ciano.Widgets.RowConversion
         * @see get_command
         * @see get_type_icon
         * @see create_row_conversion
         * @see convert_async
         * @see validate_process_completed
         * @see validate_error_in_process
         * @param  {@code ItemConversion} item
         * @param  {@code string}         name_format
         * @return {@code void}
         */
        private void start_conversion_process (ItemConversion item, string name_format) {
            try {
                var directory = File.new_for_path (item.directory);
                if (!directory.query_exists ()) {
                    directory.make_directory_with_parents();
                }

                string uri = item.directory + item.name;
                SubprocessLauncher launcher = new SubprocessLauncher (SubprocessFlags.STDERR_PIPE);
                Subprocess subprocess       = launcher.spawnv (get_command (uri));
                InputStream input_stream    = subprocess.get_stderr_pipe ();

                int error                   = 0;
                bool btn_cancel             = false;
                string icon                 = get_type_icon (item);
                RowConversion row           = create_row_conversion (icon, item.name, name_format, subprocess, btn_cancel);
                
                this.converter_view.list_conversion.list_box.add (row);

                convert_async.begin (input_stream, row, item, error, (obj, async_res) => {
                    try {
                        WidgetUtil.set_visible (row.button_cancel, false);
                        WidgetUtil.set_visible (row.button_remove, true);

                        if (subprocess.wait_check ()) {
                            validate_process_completed (subprocess, row, item, error);      
                        } 
                    } catch (Error e) {
                        validate_error_in_process (subprocess, row, item, error); 
                        GLib.warning ("Error: %s\n", e.message);
                    }
                });
            } catch (Error e) {                
                GLib.warning ("Error: %s\n", e.message);
            }
        }

        /**
         * If the conversion worked correctly: update row data.
         *
         * @see Ciano.Configs.Properties
         * @see Ciano.Utils.WidgetUtil
         * @see Ciano.Widgets.RowConversion
         * @param  {@code Subprocess}    subprocess
         * @param  {@code RowConversion} row
         * @param  {@code ItemConversion} item
         * @return {@code void}
         */
        private void validate_process_completed (Subprocess subprocess, RowConversion row, ItemConversion item, int error) throws Error {
            row.progress_bar.set_fraction (1);
            row.status.label = Properties.TEXT_SUCESS_IN_CONVERSION;
            
            if (this.settings.complete_notify) {
                send_notification (item.name, Properties.TEXT_SUCESS_IN_CONVERSION);
            } 
        }

        /**
         * Validates whether the process has been canceled (subprocess.get_exit_status () == 9) 
         * or if there has been an error (subprocess.get_exit_status () == 1).
         *
         * @see Ciano.Configs.Properties 
         * @see Ciano.Utils.WidgetUtil
         * @see Ciano.Widgets.RowConversion
         * @param  {@code Subprocess}     subprocess
         * @param  {@code RowConversion}  row
         * @param  {@code ItemConversion} item
         * @return {@code void}
         */
        private void validate_error_in_process (Subprocess subprocess, RowConversion row, ItemConversion item, int error) {
            if (subprocess.get_status () == 1) {
                row.progress_bar.set_fraction (0);
                
                if (error == 0) {
                    row.status.label = Properties.TEXT_ERROR_IN_CONVERSION;
                }

                if (this.settings.complete_notify) {
                    send_notification (item.name, Properties.TEXT_ERROR_IN_CONVERSION);
                }
            }

            if (subprocess.get_status () == 9) {
                row.progress_bar.set_fraction (0);
                row.status.label = Properties.TEXT_CANCEL_IN_CONVERSION;
            }
        }
        
        /**
         * Method to execute the command assembled by the {@code get_command} method and create a subprocess to get the
         * command output response. Doing the manipulation with each returned return (every new string returned).
         * 1 - Execute the command.
         * 2 - Create the subprocess
         * 3 - Force the return for each new line using {@code yield}.
         * 4 - Checks if you hear any errors during the conversion.
         * 5 - Validates the notation rule defined in DialogPreferences.
         *
         * @see Ciano.Configs.Properties
         * @see Ciano.Widgets.RowConversion
         * @see Ciano.Widgets.ItemConversion
         * @param  {@code string[]}       spawn_args
         * @param  {@code ItemConversion} item
         * @param  {@code string}         name_format
         * @return {@code void}
         */
        public async void convert_async (InputStream input_stream, RowConversion row, ItemConversion item, int error) {
            try {
                var charset_converter   = new CharsetConverter ("utf-8", "iso-8859-1");
                var costream            = new ConverterInputStream (input_stream, charset_converter);
                var data_input_stream   = new DataInputStream (costream);
                data_input_stream.set_newline_type (DataStreamNewlineType.ANY);
              
                int total = 0;

                while (true) {
                    string str_return = yield data_input_stream.read_line_utf8_async ();

                    if (str_return == null) {
                        break; 
                    } else {
                        // there is no return on image conversion, if display is pq was generated some error.
                        if (item.type_item != TypeItemEnum.IMAGE || this.name_format_selected.down () == "gif") {
                            process_line (str_return, row, ref total, error);
                            message(str_return);
                            if (error > 0) {
                                if (this.settings.error_notify) {
                                    send_notification (item.name, Properties.TEXT_ERROR_IN_CONVERSION);    
                                }
                                break;
                            }
                        } else {
                            error++;
                            break;
                        }
                    }
                }
            } catch (Error e) {
                GLib.critical ("Error: %s\n", e.message);
            }
        }

        /**
         * Responsible for processing the returned row and validate the return and execution of actions accordingly.
         * 1 - Monitors the time, size, duration, and bitrate of each item.
         * 2 - Also check the error if it happens.
         *
         * @see Ciano.Widgets.RowConversion
         * @see Ciano.Configs.Properties
         * @see Ciano.Utils.StringUtil
         * @see Ciano.Utils.TimeUtil
         * @param      {@code string}           str_return
         * @param  ref {@code Gtk.ProgressBar}  progress_bar
         * @param  ref {@code Gtk.Label}        status
         * @param  ref {@code int}              total
         * @return {@code void}
         */
        private void process_line (string str_return, RowConversion row, ref int total, int error) {
            string time     = StringUtil.EMPTY;
            string size     = StringUtil.EMPTY;
            string bitrate  = StringUtil.EMPTY;

            if (str_return.contains ("Duration:")) {
                int index       = str_return.index_of ("Duration:");
                string duration = str_return.substring (index + 10, 11);

                total = TimeUtil.duration_in_seconds (duration);
            }

            if (str_return.contains ("time=") && str_return.contains ("size=") && str_return.contains ("bitrate=") ) {
                int index_time  = str_return.index_of ("time=");
                time            = str_return.substring ( index_time + 5, 11);

                int loading     = TimeUtil.duration_in_seconds (time);
                double progress = (100 * loading) / total;
                row.progress_bar.set_fraction (progress / 100);
        
                int index_size  = str_return.index_of ("size=");
                size            = str_return.substring ( index_size + 5, 11);
            
                int index_bitrate = str_return.index_of ("bitrate=");
                bitrate           = str_return.substring ( index_bitrate + 8, 11);

                row.status.label = Properties.TEXT_PERCENTAGE + progress.to_string() + "%" + Properties.TEXT_SIZE_CUSTOM + size.strip () + Properties.TEXT_TIME_CUSTOM + time.strip () + Properties.TEXT_BITRATE_CUSTOM + bitrate.strip ();
            }

            if (str_return.contains ("No such file or directory")) {
                row.status.label = Properties.MSG_ERROR_NO_SUCH_FILE_DIRECTORY;
                row.status.get_style_context ().add_class ("color-label-error");
                error++;
            } else if (str_return.contains ("Invalid argument")) {
                row.status.label = Properties.MSG_ERROR_INVALID_ARGUMENT;
                row.status.get_style_context ().add_class ("color-label-error");
                error++;
            } else if (str_return.contains ("Experimental codecs are not enabled")) {
                row.status.label = Properties.MSG_ERROR_CODECS;
                row.status.get_style_context ().add_class ("color-label-error");
                error++;
            } else if (str_return.contains ("Invalid data found when processing input")) {
                row.status.label = Properties.MSG_ERROR_INVALID_INPUT_DATA;
                row.status.get_style_context ().add_class ("color-label-error");
                error++;
            }
        }