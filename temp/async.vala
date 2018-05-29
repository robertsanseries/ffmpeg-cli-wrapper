using Gtk;

public SourceFunc callback;

public async void asyncProc ()
{
    callback = asyncProc.callback;

    stdout.printf ("STEEP -- 1 --\n");

    yield;//Return to Main after the *1

    stdout.printf ("STEEP -- 2 --\n");
}

public static int main (string[] args)
{
    Gtk.init (ref args);

    var win = new Window ();
    win.set_title ("Async Functions Test");
    win.set_default_size (512,100);
    win.set_border_width (12);

    win.destroy.connect (Gtk.main_quit);

    var boton = new Button.with_label ("  Print in Terminal  ");

    boton.clicked.connect (()=> { 
        asyncProc.begin ();

        //--> Return of YIELD

        stdout.printf ("STEEP -- B --\n");
        callback ();//--> Return just after the last executed yield (... *1)
    });

    win.add (boton);
    win.show_all ();

    Gtk.main ();
    return 0;
}