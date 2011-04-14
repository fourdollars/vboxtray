VALAC := valac

vboxtray: vboxtray.vala
	$(VALAC) --pkg gtk+-2.0 $<

clean:
	$(RM) vboxtray

.PHONY: clean vboxtray
