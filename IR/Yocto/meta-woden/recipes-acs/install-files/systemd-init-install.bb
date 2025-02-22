LICENSE = "CLOSED"
inherit systemd
DEPENDS = "ebbr-sct"
SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "acs_run-before-login-prompt.service"

SRC_URI:append = " file://acs_run-before-login-prompt.service \
                   file://init.sh \
                   file://secure_init.sh \
		            "

FILES:${PN} += "${systemd_unitdir}/system"

do_install:append() {
  echo "S is ${S}"
  install -d ${D}${systemd_unitdir}/system
  install -d ${D}${bindir}
  install -d ${D}/bin
  install -m 0770 ${WORKDIR}/init.sh                             ${D}${bindir}
  install -m 0770 ${WORKDIR}/../../ebbr-sct/1.0-r0/bbr-acs/ebbr/config/ir_bbr_fwts_tests.ini ${D}${bindir}
  install -m 0770 ${WORKDIR}/secure_init.sh                      ${D}${bindir}
  install -m 0770 ${WORKDIR}/../../ebbr-sct/1.0-r0/bbr-acs/bbsr/config/bbsr_fwts_tests.ini   ${D}/bin
  install -m 0644 ${WORKDIR}/acs_run-before-login-prompt.service ${D}${systemd_unitdir}/system

}
