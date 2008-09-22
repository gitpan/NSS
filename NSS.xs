#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdlib.h>

#include <nss.h>

#include "ppport.h"

static const char * config_dir = NULL;

MODULE = NSS		PACKAGE = NSS		

const char *
config_dir(pkg)
    const char *pkg;
    CODE:
        RETVAL = savepv(config_dir);
    OUTPUT:
        RETVAL

bool
set_config_dir(pkg, dir)
    const char *pkg;
    const char *dir;
    CODE:
        if (!NSS_IsInitialized()) {
            config_dir = dir;
            RETVAL = TRUE;
        }
        else
            RETVAL = FALSE;
    OUTPUT:
        RETVAL

SECStatus
initialize(pkg)
    const char *pkg;
    CODE:
        if (!NSS_IsInitialized()) {
            RETVAL = NSS_Init(config_dir);
        }
        else
            RETVAL = SECFailure;
    OUTPUT:
        RETVAL

bool
is_initialized(pkg)
    const char *pkg;
    CODE:
        RETVAL = (bool) NSS_IsInitialized();
    OUTPUT:
        RETVAL
    
BOOT:
    config_dir = ".";