/* bsp.c - bspwm/sway-style autotiling layout for dwm
 *
 * Every window splits the space that is left along its LONGEST side
 * (wide area -> left | right, tall area -> top / bottom).
 * With mfact = 0.50 every split is exactly half, so two windows on
 * one tag always get 50% of the screen each.
 *
 * Does not depend on any other patch. Named "bsp" so it does not clash
 * with dwindle()/spiral() from the fibonacci patch.
 */
static void
bsp(Monitor *m)
{
	unsigned int i, n;
	int nx, ny, nw, nh, w, h;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++);
	if (n == 0)
		return;

	nx = m->wx;
	ny = m->wy;
	nw = m->ww;
	nh = m->wh;

	for (i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++) {
		if (i < n - 1) {
			if (nw >= nh) {            /* wide: cut left | right */
				w = nw * m->mfact;
				resize(c, nx, ny, w - 2 * c->bw, nh - 2 * c->bw, 0);
				nx += w;
				nw -= w;
			} else {                   /* tall: cut top / bottom */
				h = nh * m->mfact;
				resize(c, nx, ny, nw - 2 * c->bw, h - 2 * c->bw, 0);
				ny += h;
				nh -= h;
			}
		} else                             /* last window takes what is left */
			resize(c, nx, ny, nw - 2 * c->bw, nh - 2 * c->bw, 0);
	}
}
