VERSION=0.2
DESTDIR?=
PREFIX?=/usr
BIN=valaswig
FILES=main.vala swigcompiler.vala swigwriter.vala 
VALAPKG=`pkg-config --list-all|grep vala-|tail -n 1|awk '{print $$1}'`

all:
	valac -g --pkg posix --pkg ${VALAPKG} ${FILES} -o ${BIN}

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	mkdir -p ${DESTDIR}${PREFIX}/share/man/man1
	cp ${BIN}.1 ${DESTDIR}${PREFIX}/share/man/man1
	cp ${BIN}-cc.1 ${DESTDIR}${PREFIX}/share/man/man1
	cp ${BIN} ${DESTDIR}${PREFIX}/bin
	cp ${BIN}-cc ${DESTDIR}${PREFIX}/bin

dist:
	rm -rf valaswig-${VERSION}
	hg clone . valaswig-${VERSION}
	rm -rf .valaswig-${VERSION}/.hg*
	tar czvf valaswig-${VERSION}.tar.gz valaswig-${VERSION}

clean:
	rm -f valaswig

deinstall: uninstall

uninstall:
	-rm ${DESTDIR}${PREFIX}/bin/${BIN}
	-rm ${DESTDIR}${PREFIX}/bin/${BIN}-cc

.PHONY: all clean dist install uninstall deinstall
