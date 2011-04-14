/* -*- coding: utf-8; indent-tabs-mode: nil; tab-width: 4; c-basic-offset: 4; -*- */
/* vim:set fileencodings=utf-8 tabstop=4 expandtab shiftwidth=4 softtabstop=4: */
/**
 * Copyright (C) 2011 Shih-Yuan Lee (FourDollars) <fourdollars@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

class VBoxTray : GLib.Object {
    private Gtk.StatusIcon icon = null;
    private Gtk.Menu menu = null;

    public static void main (string[] args) {
        Gtk.init(ref args);
        var app = new VBoxTray();
        app.run();
    }

    public VBoxTray () {
        if (FileUtils.test("/usr/share/pixmaps/VBox.png", FileTest.IS_REGULAR) == true) {
            icon = new Gtk.StatusIcon.from_file("/usr/share/pixmaps/VBox.png");
        } else {
            icon = new Gtk.StatusIcon.from_stock(Gtk.STOCK_MISSING_IMAGE);
        }

        icon.set_tooltip_text("VBoxTray");

        menu = new Gtk.Menu();

        unowned SList<Gtk.RadioMenuItem> group = null;

        menu.append(new Gtk.SeparatorMenuItem());

        var quit = new Gtk.RadioMenuItem.with_label(group, "Quit");
        menu.append(quit);
        quit.activate.connect((e) => {
            Gtk.main_quit();
        });

        menu.show_all();

        icon.button_release_event.connect((e) => {
            menu.popup(null, null, null, e.button, e.time);
            return true;
        });
    }

    public void run() {
        Gtk.main();
    }
}
