/* dock.h - lets dwm ignore dock/panel windows (e.g. a Quickshell bar)
 *
 * Returns 1 if the window has _NET_WM_WINDOW_TYPE_DOCK in its
 * _NET_WM_WINDOW_TYPE list, so dwm can leave it alone instead of tiling it.
 * Needs <X11/Xlib.h> and <X11/Xatom.h>, which dwm.c already includes.
 */
static int
isdock(Display *d, Window w)
{
	Atom da, *types = NULL;
	Atom dock = XInternAtom(d, "_NET_WM_WINDOW_TYPE_DOCK", False);
	int di, found = 0;
	unsigned long i, n, dl;

	if (XGetWindowProperty(d, w, XInternAtom(d, "_NET_WM_WINDOW_TYPE", False),
	    0L, 16L, False, XA_ATOM, &da, &di, &n, &dl, (unsigned char **)&types) == Success && types) {
		for (i = 0; i < n; i++)
			if (types[i] == dock)
				found = 1;
		XFree(types);
	}
	return found;
}
