/*
 * Standard meta values for builtin configurable options.
 */

module c.jit_const;

const JIT_OPTION_CACHE_LIMIT = 10000;

const JIT_OPTION_CACHE_PAGE_SIZE = 10001;

const JIT_OPTION_PRE_COMPILE = 10002;

const JIT_OPTION_DONT_FOLD = 10003;

const JIT_OPTION_POSITION_INDEPENDENT = 10004;

const JIT_OPTION_CACHE_MAX_PAGE_FACTOR = 10005;




const JIT_DEBUGGER_TYPE_QUIT = 0;

const JIT_DEBUGGER_TYPE_HARD_BREAKPOINT = 1;

const JIT_DEBUGGER_TYPE_SOFT_BREAKPOINT = 2;

const JIT_DEBUGGER_TYPE_USER_BREAKPOINT = 3;

const JIT_DEBUGGER_TYPE_ATTACH_THREAD = 4;

const JIT_DEBUGGER_TYPE_DETACH_THREAD = 5;



const JIT_DEBUGGER_DATA1_FIRST = 10000;

const JIT_DEBUGGER_DATA1_LINE = 10000;

const JIT_DEBUGGER_DATA1_ENTER = 10001;

const JIT_DEBUGGER_DATA1_LEAVE = 10002;

const JIT_DEBUGGER_DATA1_THROW = 10003;






const JIT_NATIVE_INT32 = 1;

const JIT_NFLOAT_IS_DOUBLE = 1;




/*
 * C++ name mangling definitions.
 */


const JIT_MANGLE_PUBLIC = 0x0001;

const JIT_MANGLE_PROTECTED = 0x0002;

const JIT_MANGLE_PRIVATE = 0x0003;

const JIT_MANGLE_STATIC = 0x0008;

const JIT_MANGLE_VIRTUAL = 0x0010;

const JIT_MANGLE_CONST = 0x0020;

const JIT_MANGLE_EXPLICIT_THIS = 0x0040;

const JIT_MANGLE_IS_CTOR = 0x0080;

const JIT_MANGLE_IS_DTOR = 0x0100;

const JIT_MANGLE_BASE = 0x0200;








/*
 * Result codes from "jit_readelf_open".
 */


const JIT_READELF_OK = 0;

const JIT_READELF_CANNOT_OPEN = 1;

const JIT_READELF_NOT_ELF = 2;

const JIT_READELF_WRONG_ARCH = 3;

const JIT_READELF_BAD_FORMAT = 4;

const JIT_READELF_MEMORY = 5;









/* Optimization levels */


const JIT_OPTLEVEL_NONE = 0;

const JIT_OPTLEVEL_NORMAL = 1;







/*
 * Result values for "_jit_cache_start_function" and "_jit_cache_end_function".
 */


const JIT_MEMORY_OK = 0;

const JIT_MEMORY_RESTART = 1;

const JIT_MEMORY_TOO_BIG = 2;

const JIT_MEMORY_ERROR = 3;





/*
 * Modifier flags that describe an item's properties.
 */


const JITOM_MODIFIER_ACCESS_MASK = 0x0007;

const JITOM_MODIFIER_PUBLIC = 0x0000;

const JITOM_MODIFIER_PRIVATE = 0x0001;

const JITOM_MODIFIER_PROTECTED = 0x0002;

const JITOM_MODIFIER_PACKAGE = 0x0003;

const JITOM_MODIFIER_PACKAGE_OR_PROTECTED = 0x0004;

const JITOM_MODIFIER_PACKAGE_AND_PROTECTED = 0x0005;

const JITOM_MODIFIER_OTHER1 = 0x0006;

const JITOM_MODIFIER_OTHER2 = 0x0007;

const JITOM_MODIFIER_STATIC = 0x0008;

const JITOM_MODIFIER_VIRTUAL = 0x0010;

const JITOM_MODIFIER_NEW_SLOT = 0x0020;

const JITOM_MODIFIER_ABSTRACT = 0x0040;

const JITOM_MODIFIER_LITERAL = 0x0080;

const JITOM_MODIFIER_CTOR = 0x0100;

const JITOM_MODIFIER_STATIC_CTOR = 0x0200;

const JITOM_MODIFIER_DTOR = 0x0400;

const JITOM_MODIFIER_INTERFACE = 0x0800;

const JITOM_MODIFIER_VALUE = 0x1000;

const JITOM_MODIFIER_FINAL = 0x2000;

const JITOM_MODIFIER_DELETE = 0x4000;

const JITOM_MODIFIER_REFERENCE_COUNTED = 0x8000;
/*
 * Type tags that are used to mark instances of object model classes.
 */


const JITOM_TYPETAG_CLASS = 11000;

const JITOM_TYPETAG_VALUE = 11001;










const JIT_OP_NOP = 0x0000;

const JIT_OP_TRUNC_SBYTE = 0x0001;

const JIT_OP_TRUNC_UBYTE = 0x0002;

const JIT_OP_TRUNC_SHORT = 0x0003;

const JIT_OP_TRUNC_USHORT = 0x0004;

const JIT_OP_TRUNC_INT = 0x0005;

const JIT_OP_TRUNC_UINT = 0x0006;

const JIT_OP_CHECK_SBYTE = 0x0007;

const JIT_OP_CHECK_UBYTE = 0x0008;

const JIT_OP_CHECK_SHORT = 0x0009;

const JIT_OP_CHECK_USHORT = 0x000A;

const JIT_OP_CHECK_INT = 0x000B;

const JIT_OP_CHECK_UINT = 0x000C;

const JIT_OP_LOW_WORD = 0x000D;

const JIT_OP_EXPAND_INT = 0x000E;

const JIT_OP_EXPAND_UINT = 0x000F;

const JIT_OP_CHECK_LOW_WORD = 0x0010;

const JIT_OP_CHECK_SIGNED_LOW_WORD = 0x0011;

const JIT_OP_CHECK_LONG = 0x0012;

const JIT_OP_CHECK_ULONG = 0x0013;

const JIT_OP_FLOAT32_TO_INT = 0x0014;

const JIT_OP_FLOAT32_TO_UINT = 0x0015;

const JIT_OP_FLOAT32_TO_LONG = 0x0016;

const JIT_OP_FLOAT32_TO_ULONG = 0x0017;

const JIT_OP_CHECK_FLOAT32_TO_INT = 0x0018;

const JIT_OP_CHECK_FLOAT32_TO_UINT = 0x0019;

const JIT_OP_CHECK_FLOAT32_TO_LONG = 0x001A;

const JIT_OP_CHECK_FLOAT32_TO_ULONG = 0x001B;

const JIT_OP_INT_TO_FLOAT32 = 0x001C;

const JIT_OP_UINT_TO_FLOAT32 = 0x001D;

const JIT_OP_LONG_TO_FLOAT32 = 0x001E;

const JIT_OP_ULONG_TO_FLOAT32 = 0x001F;

const JIT_OP_FLOAT32_TO_FLOAT64 = 0x0020;

const JIT_OP_FLOAT64_TO_INT = 0x0021;

const JIT_OP_FLOAT64_TO_UINT = 0x0022;

const JIT_OP_FLOAT64_TO_LONG = 0x0023;

const JIT_OP_FLOAT64_TO_ULONG = 0x0024;

const JIT_OP_CHECK_FLOAT64_TO_INT = 0x0025;

const JIT_OP_CHECK_FLOAT64_TO_UINT = 0x0026;

const JIT_OP_CHECK_FLOAT64_TO_LONG = 0x0027;

const JIT_OP_CHECK_FLOAT64_TO_ULONG = 0x0028;

const JIT_OP_INT_TO_FLOAT64 = 0x0029;

const JIT_OP_UINT_TO_FLOAT64 = 0x002A;

const JIT_OP_LONG_TO_FLOAT64 = 0x002B;

const JIT_OP_ULONG_TO_FLOAT64 = 0x002C;

const JIT_OP_FLOAT64_TO_FLOAT32 = 0x002D;

const JIT_OP_NFLOAT_TO_INT = 0x002E;

const JIT_OP_NFLOAT_TO_UINT = 0x002F;

const JIT_OP_NFLOAT_TO_LONG = 0x0030;

const JIT_OP_NFLOAT_TO_ULONG = 0x0031;

const JIT_OP_CHECK_NFLOAT_TO_INT = 0x0032;

const JIT_OP_CHECK_NFLOAT_TO_UINT = 0x0033;

const JIT_OP_CHECK_NFLOAT_TO_LONG = 0x0034;

const JIT_OP_CHECK_NFLOAT_TO_ULONG = 0x0035;

const JIT_OP_INT_TO_NFLOAT = 0x0036;

const JIT_OP_UINT_TO_NFLOAT = 0x0037;

const JIT_OP_LONG_TO_NFLOAT = 0x0038;

const JIT_OP_ULONG_TO_NFLOAT = 0x0039;

const JIT_OP_NFLOAT_TO_FLOAT32 = 0x003A;

const JIT_OP_NFLOAT_TO_FLOAT64 = 0x003B;

const JIT_OP_FLOAT32_TO_NFLOAT = 0x003C;

const JIT_OP_FLOAT64_TO_NFLOAT = 0x003D;

const JIT_OP_IADD = 0x003E;

const JIT_OP_IADD_OVF = 0x003F;

const JIT_OP_IADD_OVF_UN = 0x0040;

const JIT_OP_ISUB = 0x0041;

const JIT_OP_ISUB_OVF = 0x0042;

const JIT_OP_ISUB_OVF_UN = 0x0043;

const JIT_OP_IMUL = 0x0044;

const JIT_OP_IMUL_OVF = 0x0045;

const JIT_OP_IMUL_OVF_UN = 0x0046;

const JIT_OP_IDIV = 0x0047;

const JIT_OP_IDIV_UN = 0x0048;

const JIT_OP_IREM = 0x0049;

const JIT_OP_IREM_UN = 0x004A;

const JIT_OP_INEG = 0x004B;

const JIT_OP_LADD = 0x004C;

const JIT_OP_LADD_OVF = 0x004D;

const JIT_OP_LADD_OVF_UN = 0x004E;

const JIT_OP_LSUB = 0x004F;

const JIT_OP_LSUB_OVF = 0x0050;

const JIT_OP_LSUB_OVF_UN = 0x0051;

const JIT_OP_LMUL = 0x0052;

const JIT_OP_LMUL_OVF = 0x0053;

const JIT_OP_LMUL_OVF_UN = 0x0054;

const JIT_OP_LDIV = 0x0055;

const JIT_OP_LDIV_UN = 0x0056;

const JIT_OP_LREM = 0x0057;

const JIT_OP_LREM_UN = 0x0058;

const JIT_OP_LNEG = 0x0059;

const JIT_OP_FADD = 0x005A;

const JIT_OP_FSUB = 0x005B;

const JIT_OP_FMUL = 0x005C;

const JIT_OP_FDIV = 0x005D;

const JIT_OP_FREM = 0x005E;

const JIT_OP_FREM_IEEE = 0x005F;

const JIT_OP_FNEG = 0x0060;

const JIT_OP_DADD = 0x0061;

const JIT_OP_DSUB = 0x0062;

const JIT_OP_DMUL = 0x0063;

const JIT_OP_DDIV = 0x0064;

const JIT_OP_DREM = 0x0065;

const JIT_OP_DREM_IEEE = 0x0066;

const JIT_OP_DNEG = 0x0067;

const JIT_OP_NFADD = 0x0068;

const JIT_OP_NFSUB = 0x0069;

const JIT_OP_NFMUL = 0x006A;

const JIT_OP_NFDIV = 0x006B;

const JIT_OP_NFREM = 0x006C;

const JIT_OP_NFREM_IEEE = 0x006D;

const JIT_OP_NFNEG = 0x006E;

const JIT_OP_IAND = 0x006F;

const JIT_OP_IOR = 0x0070;

const JIT_OP_IXOR = 0x0071;

const JIT_OP_INOT = 0x0072;

const JIT_OP_ISHL = 0x0073;

const JIT_OP_ISHR = 0x0074;

const JIT_OP_ISHR_UN = 0x0075;

const JIT_OP_LAND = 0x0076;

const JIT_OP_LOR = 0x0077;

const JIT_OP_LXOR = 0x0078;

const JIT_OP_LNOT = 0x0079;

const JIT_OP_LSHL = 0x007A;

const JIT_OP_LSHR = 0x007B;

const JIT_OP_LSHR_UN = 0x007C;

const JIT_OP_BR = 0x007D;

const JIT_OP_BR_IFALSE = 0x007E;

const JIT_OP_BR_ITRUE = 0x007F;

const JIT_OP_BR_IEQ = 0x0080;

const JIT_OP_BR_INE = 0x0081;

const JIT_OP_BR_ILT = 0x0082;

const JIT_OP_BR_ILT_UN = 0x0083;

const JIT_OP_BR_ILE = 0x0084;

const JIT_OP_BR_ILE_UN = 0x0085;

const JIT_OP_BR_IGT = 0x0086;

const JIT_OP_BR_IGT_UN = 0x0087;

const JIT_OP_BR_IGE = 0x0088;

const JIT_OP_BR_IGE_UN = 0x0089;

const JIT_OP_BR_LFALSE = 0x008A;

const JIT_OP_BR_LTRUE = 0x008B;

const JIT_OP_BR_LEQ = 0x008C;

const JIT_OP_BR_LNE = 0x008D;

const JIT_OP_BR_LLT = 0x008E;

const JIT_OP_BR_LLT_UN = 0x008F;

const JIT_OP_BR_LLE = 0x0090;

const JIT_OP_BR_LLE_UN = 0x0091;

const JIT_OP_BR_LGT = 0x0092;

const JIT_OP_BR_LGT_UN = 0x0093;

const JIT_OP_BR_LGE = 0x0094;

const JIT_OP_BR_LGE_UN = 0x0095;

const JIT_OP_BR_FEQ = 0x0096;

const JIT_OP_BR_FNE = 0x0097;

const JIT_OP_BR_FLT = 0x0098;

const JIT_OP_BR_FLE = 0x0099;

const JIT_OP_BR_FGT = 0x009A;

const JIT_OP_BR_FGE = 0x009B;

const JIT_OP_BR_FLT_INV = 0x009C;

const JIT_OP_BR_FLE_INV = 0x009D;

const JIT_OP_BR_FGT_INV = 0x009E;

const JIT_OP_BR_FGE_INV = 0x009F;

const JIT_OP_BR_DEQ = 0x00A0;

const JIT_OP_BR_DNE = 0x00A1;

const JIT_OP_BR_DLT = 0x00A2;

const JIT_OP_BR_DLE = 0x00A3;

const JIT_OP_BR_DGT = 0x00A4;

const JIT_OP_BR_DGE = 0x00A5;

const JIT_OP_BR_DLT_INV = 0x00A6;

const JIT_OP_BR_DLE_INV = 0x00A7;

const JIT_OP_BR_DGT_INV = 0x00A8;

const JIT_OP_BR_DGE_INV = 0x00A9;

const JIT_OP_BR_NFEQ = 0x00AA;

const JIT_OP_BR_NFNE = 0x00AB;

const JIT_OP_BR_NFLT = 0x00AC;

const JIT_OP_BR_NFLE = 0x00AD;

const JIT_OP_BR_NFGT = 0x00AE;

const JIT_OP_BR_NFGE = 0x00AF;

const JIT_OP_BR_NFLT_INV = 0x00B0;

const JIT_OP_BR_NFLE_INV = 0x00B1;

const JIT_OP_BR_NFGT_INV = 0x00B2;

const JIT_OP_BR_NFGE_INV = 0x00B3;

const JIT_OP_ICMP = 0x00B4;

const JIT_OP_ICMP_UN = 0x00B5;

const JIT_OP_LCMP = 0x00B6;

const JIT_OP_LCMP_UN = 0x00B7;

const JIT_OP_FCMPL = 0x00B8;

const JIT_OP_FCMPG = 0x00B9;

const JIT_OP_DCMPL = 0x00BA;

const JIT_OP_DCMPG = 0x00BB;

const JIT_OP_NFCMPL = 0x00BC;

const JIT_OP_NFCMPG = 0x00BD;

const JIT_OP_IEQ = 0x00BE;

const JIT_OP_INE = 0x00BF;

const JIT_OP_ILT = 0x00C0;

const JIT_OP_ILT_UN = 0x00C1;

const JIT_OP_ILE = 0x00C2;

const JIT_OP_ILE_UN = 0x00C3;

const JIT_OP_IGT = 0x00C4;

const JIT_OP_IGT_UN = 0x00C5;

const JIT_OP_IGE = 0x00C6;

const JIT_OP_IGE_UN = 0x00C7;

const JIT_OP_LEQ = 0x00C8;

const JIT_OP_LNE = 0x00C9;

const JIT_OP_LLT = 0x00CA;

const JIT_OP_LLT_UN = 0x00CB;

const JIT_OP_LLE = 0x00CC;

const JIT_OP_LLE_UN = 0x00CD;

const JIT_OP_LGT = 0x00CE;

const JIT_OP_LGT_UN = 0x00CF;

const JIT_OP_LGE = 0x00D0;

const JIT_OP_LGE_UN = 0x00D1;

const JIT_OP_FEQ = 0x00D2;

const JIT_OP_FNE = 0x00D3;

const JIT_OP_FLT = 0x00D4;

const JIT_OP_FLE = 0x00D5;

const JIT_OP_FGT = 0x00D6;

const JIT_OP_FGE = 0x00D7;

const JIT_OP_FLT_INV = 0x00D8;

const JIT_OP_FLE_INV = 0x00D9;

const JIT_OP_FGT_INV = 0x00DA;

const JIT_OP_FGE_INV = 0x00DB;

const JIT_OP_DEQ = 0x00DC;

const JIT_OP_DNE = 0x00DD;

const JIT_OP_DLT = 0x00DE;

const JIT_OP_DLE = 0x00DF;

const JIT_OP_DGT = 0x00E0;

const JIT_OP_DGE = 0x00E1;

const JIT_OP_DLT_INV = 0x00E2;

const JIT_OP_DLE_INV = 0x00E3;

const JIT_OP_DGT_INV = 0x00E4;

const JIT_OP_DGE_INV = 0x00E5;

const JIT_OP_NFEQ = 0x00E6;

const JIT_OP_NFNE = 0x00E7;

const JIT_OP_NFLT = 0x00E8;

const JIT_OP_NFLE = 0x00E9;

const JIT_OP_NFGT = 0x00EA;

const JIT_OP_NFGE = 0x00EB;

const JIT_OP_NFLT_INV = 0x00EC;

const JIT_OP_NFLE_INV = 0x00ED;

const JIT_OP_NFGT_INV = 0x00EE;

const JIT_OP_NFGE_INV = 0x00EF;

const JIT_OP_IS_FNAN = 0x00F0;

const JIT_OP_IS_FINF = 0x00F1;

const JIT_OP_IS_FFINITE = 0x00F2;

const JIT_OP_IS_DNAN = 0x00F3;

const JIT_OP_IS_DINF = 0x00F4;

const JIT_OP_IS_DFINITE = 0x00F5;

const JIT_OP_IS_NFNAN = 0x00F6;

const JIT_OP_IS_NFINF = 0x00F7;

const JIT_OP_IS_NFFINITE = 0x00F8;

const JIT_OP_FACOS = 0x00F9;

const JIT_OP_FASIN = 0x00FA;

const JIT_OP_FATAN = 0x00FB;

const JIT_OP_FATAN2 = 0x00FC;

const JIT_OP_FCEIL = 0x00FD;

const JIT_OP_FCOS = 0x00FE;

const JIT_OP_FCOSH = 0x00FF;

const JIT_OP_FEXP = 0x0100;

const JIT_OP_FFLOOR = 0x0101;

const JIT_OP_FLOG = 0x0102;

const JIT_OP_FLOG10 = 0x0103;

const JIT_OP_FPOW = 0x0104;

const JIT_OP_FRINT = 0x0105;

const JIT_OP_FROUND = 0x0106;

const JIT_OP_FSIN = 0x0107;

const JIT_OP_FSINH = 0x0108;

const JIT_OP_FSQRT = 0x0109;

const JIT_OP_FTAN = 0x010A;

const JIT_OP_FTANH = 0x010B;

const JIT_OP_FTRUNC = 0x010C;

const JIT_OP_DACOS = 0x010D;

const JIT_OP_DASIN = 0x010E;

const JIT_OP_DATAN = 0x010F;

const JIT_OP_DATAN2 = 0x0110;

const JIT_OP_DCEIL = 0x0111;

const JIT_OP_DCOS = 0x0112;

const JIT_OP_DCOSH = 0x0113;

const JIT_OP_DEXP = 0x0114;

const JIT_OP_DFLOOR = 0x0115;

const JIT_OP_DLOG = 0x0116;

const JIT_OP_DLOG10 = 0x0117;

const JIT_OP_DPOW = 0x0118;

const JIT_OP_DRINT = 0x0119;

const JIT_OP_DROUND = 0x011A;

const JIT_OP_DSIN = 0x011B;

const JIT_OP_DSINH = 0x011C;

const JIT_OP_DSQRT = 0x011D;

const JIT_OP_DTAN = 0x011E;

const JIT_OP_DTANH = 0x011F;

const JIT_OP_DTRUNC = 0x0120;

const JIT_OP_NFACOS = 0x0121;

const JIT_OP_NFASIN = 0x0122;

const JIT_OP_NFATAN = 0x0123;

const JIT_OP_NFATAN2 = 0x0124;

const JIT_OP_NFCEIL = 0x0125;

const JIT_OP_NFCOS = 0x0126;

const JIT_OP_NFCOSH = 0x0127;

const JIT_OP_NFEXP = 0x0128;

const JIT_OP_NFFLOOR = 0x0129;

const JIT_OP_NFLOG = 0x012A;

const JIT_OP_NFLOG10 = 0x012B;

const JIT_OP_NFPOW = 0x012C;

const JIT_OP_NFRINT = 0x012D;

const JIT_OP_NFROUND = 0x012E;

const JIT_OP_NFSIN = 0x012F;

const JIT_OP_NFSINH = 0x0130;

const JIT_OP_NFSQRT = 0x0131;

const JIT_OP_NFTAN = 0x0132;

const JIT_OP_NFTANH = 0x0133;

const JIT_OP_NFTRUNC = 0x0134;

const JIT_OP_IABS = 0x0135;

const JIT_OP_LABS = 0x0136;

const JIT_OP_FABS = 0x0137;

const JIT_OP_DABS = 0x0138;

const JIT_OP_NFABS = 0x0139;

const JIT_OP_IMIN = 0x013A;

const JIT_OP_IMIN_UN = 0x013B;

const JIT_OP_LMIN = 0x013C;

const JIT_OP_LMIN_UN = 0x013D;

const JIT_OP_FMIN = 0x013E;

const JIT_OP_DMIN = 0x013F;

const JIT_OP_NFMIN = 0x0140;

const JIT_OP_IMAX = 0x0141;

const JIT_OP_IMAX_UN = 0x0142;

const JIT_OP_LMAX = 0x0143;

const JIT_OP_LMAX_UN = 0x0144;

const JIT_OP_FMAX = 0x0145;

const JIT_OP_DMAX = 0x0146;

const JIT_OP_NFMAX = 0x0147;

const JIT_OP_ISIGN = 0x0148;

const JIT_OP_LSIGN = 0x0149;

const JIT_OP_FSIGN = 0x014A;

const JIT_OP_DSIGN = 0x014B;

const JIT_OP_NFSIGN = 0x014C;

const JIT_OP_CHECK_NULL = 0x014D;

const JIT_OP_CALL = 0x014E;

const JIT_OP_CALL_TAIL = 0x014F;

const JIT_OP_CALL_INDIRECT = 0x0150;

const JIT_OP_CALL_INDIRECT_TAIL = 0x0151;

const JIT_OP_CALL_VTABLE_PTR = 0x0152;

const JIT_OP_CALL_VTABLE_PTR_TAIL = 0x0153;

const JIT_OP_CALL_EXTERNAL = 0x0154;

const JIT_OP_CALL_EXTERNAL_TAIL = 0x0155;

const JIT_OP_RETURN = 0x0156;

const JIT_OP_RETURN_INT = 0x0157;

const JIT_OP_RETURN_LONG = 0x0158;

const JIT_OP_RETURN_FLOAT32 = 0x0159;

const JIT_OP_RETURN_FLOAT64 = 0x015A;

const JIT_OP_RETURN_NFLOAT = 0x015B;

const JIT_OP_RETURN_SMALL_STRUCT = 0x015C;

const JIT_OP_SETUP_FOR_NESTED = 0x015D;

const JIT_OP_SETUP_FOR_SIBLING = 0x015E;

const JIT_OP_IMPORT = 0x015F;

const JIT_OP_THROW = 0x0160;

const JIT_OP_RETHROW = 0x0161;

const JIT_OP_LOAD_PC = 0x0162;

const JIT_OP_LOAD_EXCEPTION_PC = 0x0163;

const JIT_OP_ENTER_FINALLY = 0x0164;

const JIT_OP_LEAVE_FINALLY = 0x0165;

const JIT_OP_CALL_FINALLY = 0x0166;

const JIT_OP_ENTER_FILTER = 0x0167;

const JIT_OP_LEAVE_FILTER = 0x0168;

const JIT_OP_CALL_FILTER = 0x0169;

const JIT_OP_CALL_FILTER_RETURN = 0x016A;

const JIT_OP_ADDRESS_OF_LABEL = 0x016B;

const JIT_OP_COPY_LOAD_SBYTE = 0x016C;

const JIT_OP_COPY_LOAD_UBYTE = 0x016D;

const JIT_OP_COPY_LOAD_SHORT = 0x016E;

const JIT_OP_COPY_LOAD_USHORT = 0x016F;

const JIT_OP_COPY_INT = 0x0170;

const JIT_OP_COPY_LONG = 0x0171;

const JIT_OP_COPY_FLOAT32 = 0x0172;

const JIT_OP_COPY_FLOAT64 = 0x0173;

const JIT_OP_COPY_NFLOAT = 0x0174;

const JIT_OP_COPY_STRUCT = 0x0175;

const JIT_OP_COPY_STORE_BYTE = 0x0176;

const JIT_OP_COPY_STORE_SHORT = 0x0177;

const JIT_OP_ADDRESS_OF = 0x0178;

const JIT_OP_INCOMING_REG = 0x0179;

const JIT_OP_INCOMING_FRAME_POSN = 0x017A;

const JIT_OP_OUTGOING_REG = 0x017B;

const JIT_OP_OUTGOING_FRAME_POSN = 0x017C;

const JIT_OP_RETURN_REG = 0x017D;

const JIT_OP_PUSH_INT = 0x017E;

const JIT_OP_PUSH_LONG = 0x017F;

const JIT_OP_PUSH_FLOAT32 = 0x0180;

const JIT_OP_PUSH_FLOAT64 = 0x0181;

const JIT_OP_PUSH_NFLOAT = 0x0182;

const JIT_OP_PUSH_STRUCT = 0x0183;

const JIT_OP_POP_STACK = 0x0184;

const JIT_OP_FLUSH_SMALL_STRUCT = 0x0185;

const JIT_OP_SET_PARAM_INT = 0x0186;

const JIT_OP_SET_PARAM_LONG = 0x0187;

const JIT_OP_SET_PARAM_FLOAT32 = 0x0188;

const JIT_OP_SET_PARAM_FLOAT64 = 0x0189;

const JIT_OP_SET_PARAM_NFLOAT = 0x018A;

const JIT_OP_SET_PARAM_STRUCT = 0x018B;

const JIT_OP_PUSH_RETURN_AREA_PTR = 0x018C;

const JIT_OP_LOAD_RELATIVE_SBYTE = 0x018D;

const JIT_OP_LOAD_RELATIVE_UBYTE = 0x018E;

const JIT_OP_LOAD_RELATIVE_SHORT = 0x018F;

const JIT_OP_LOAD_RELATIVE_USHORT = 0x0190;

const JIT_OP_LOAD_RELATIVE_INT = 0x0191;

const JIT_OP_LOAD_RELATIVE_LONG = 0x0192;

const JIT_OP_LOAD_RELATIVE_FLOAT32 = 0x0193;

const JIT_OP_LOAD_RELATIVE_FLOAT64 = 0x0194;

const JIT_OP_LOAD_RELATIVE_NFLOAT = 0x0195;

const JIT_OP_LOAD_RELATIVE_STRUCT = 0x0196;

const JIT_OP_STORE_RELATIVE_BYTE = 0x0197;

const JIT_OP_STORE_RELATIVE_SHORT = 0x0198;

const JIT_OP_STORE_RELATIVE_INT = 0x0199;

const JIT_OP_STORE_RELATIVE_LONG = 0x019A;

const JIT_OP_STORE_RELATIVE_FLOAT32 = 0x019B;

const JIT_OP_STORE_RELATIVE_FLOAT64 = 0x019C;

const JIT_OP_STORE_RELATIVE_NFLOAT = 0x019D;

const JIT_OP_STORE_RELATIVE_STRUCT = 0x019E;

const JIT_OP_ADD_RELATIVE = 0x019F;

const JIT_OP_LOAD_ELEMENT_SBYTE = 0x01A0;

const JIT_OP_LOAD_ELEMENT_UBYTE = 0x01A1;

const JIT_OP_LOAD_ELEMENT_SHORT = 0x01A2;

const JIT_OP_LOAD_ELEMENT_USHORT = 0x01A3;

const JIT_OP_LOAD_ELEMENT_INT = 0x01A4;

const JIT_OP_LOAD_ELEMENT_LONG = 0x01A5;

const JIT_OP_LOAD_ELEMENT_FLOAT32 = 0x01A6;

const JIT_OP_LOAD_ELEMENT_FLOAT64 = 0x01A7;

const JIT_OP_LOAD_ELEMENT_NFLOAT = 0x01A8;

const JIT_OP_STORE_ELEMENT_BYTE = 0x01A9;

const JIT_OP_STORE_ELEMENT_SHORT = 0x01AA;

const JIT_OP_STORE_ELEMENT_INT = 0x01AB;

const JIT_OP_STORE_ELEMENT_LONG = 0x01AC;

const JIT_OP_STORE_ELEMENT_FLOAT32 = 0x01AD;

const JIT_OP_STORE_ELEMENT_FLOAT64 = 0x01AE;

const JIT_OP_STORE_ELEMENT_NFLOAT = 0x01AF;

const JIT_OP_MEMCPY = 0x01B0;

const JIT_OP_MEMMOVE = 0x01B1;

const JIT_OP_MEMSET = 0x01B2;

const JIT_OP_ALLOCA = 0x01B3;

const JIT_OP_MARK_OFFSET = 0x01B4;

const JIT_OP_MARK_BREAKPOINT = 0x01B5;

const JIT_OP_JUMP_TABLE = 0x01B6;

const JIT_OP_NUM_OPCODES = 0x01B7;
/*
 * Opcode information.
 */

extern (C):
alias jit_opcode_info jit_opcode_info_t;





struct jit_opcode_info
{
    char *name;
    int flags;
}


const JIT_OPCODE_DEST_MASK = 0x0000000F;

const JIT_OPCODE_DEST_EMPTY = 0x00000000;

const JIT_OPCODE_DEST_INT = 0x00000001;

const JIT_OPCODE_DEST_LONG = 0x00000002;

const JIT_OPCODE_DEST_FLOAT32 = 0x00000003;

const JIT_OPCODE_DEST_FLOAT64 = 0x00000004;

const JIT_OPCODE_DEST_NFLOAT = 0x00000005;

const JIT_OPCODE_DEST_ANY = 0x00000006;

const JIT_OPCODE_SRC1_MASK = 0x000000F0;

const JIT_OPCODE_SRC1_EMPTY = 0x00000000;

const JIT_OPCODE_SRC1_INT = 0x00000010;

const JIT_OPCODE_SRC1_LONG = 0x00000020;

const JIT_OPCODE_SRC1_FLOAT32 = 0x00000030;

const JIT_OPCODE_SRC1_FLOAT64 = 0x00000040;

const JIT_OPCODE_SRC1_NFLOAT = 0x00000050;

const JIT_OPCODE_SRC1_ANY = 0x00000060;

const JIT_OPCODE_SRC2_MASK = 0x00000F00;

const JIT_OPCODE_SRC2_EMPTY = 0x00000000;

const JIT_OPCODE_SRC2_INT = 0x00000100;

const JIT_OPCODE_SRC2_LONG = 0x00000200;

const JIT_OPCODE_SRC2_FLOAT32 = 0x00000300;

const JIT_OPCODE_SRC2_FLOAT64 = 0x00000400;

const JIT_OPCODE_SRC2_NFLOAT = 0x00000500;

const JIT_OPCODE_SRC2_ANY = 0x00000600;

const JIT_OPCODE_IS_BRANCH = 0x00001000;

const JIT_OPCODE_IS_CALL = 0x00002000;

const JIT_OPCODE_IS_CALL_EXTERNAL = 0x00004000;

const JIT_OPCODE_IS_REG = 0x00008000;

const JIT_OPCODE_IS_ADDROF_LABEL = 0x00010000;

const JIT_OPCODE_IS_JUMP_TABLE = 0x00020000;

const JIT_OPCODE_OPER_MASK = 0x01F00000;

const JIT_OPCODE_OPER_NONE = 0x00000000;

const JIT_OPCODE_OPER_ADD = 0x00100000;

const JIT_OPCODE_OPER_SUB = 0x00200000;

const JIT_OPCODE_OPER_MUL = 0x00300000;

const JIT_OPCODE_OPER_DIV = 0x00400000;

const JIT_OPCODE_OPER_REM = 0x00500000;

const JIT_OPCODE_OPER_NEG = 0x00600000;

const JIT_OPCODE_OPER_AND = 0x00700000;

const JIT_OPCODE_OPER_OR = 0x00800000;

const JIT_OPCODE_OPER_XOR = 0x00900000;

const JIT_OPCODE_OPER_NOT = 0x00A00000;

const JIT_OPCODE_OPER_EQ = 0x00B00000;

const JIT_OPCODE_OPER_NE = 0x00C00000;

const JIT_OPCODE_OPER_LT = 0x00D00000;

const JIT_OPCODE_OPER_LE = 0x00E00000;

const JIT_OPCODE_OPER_GT = 0x00F00000;

const JIT_OPCODE_OPER_GE = 0x01000000;

const JIT_OPCODE_OPER_SHL = 0x01100000;

const JIT_OPCODE_OPER_SHR = 0x01200000;

const JIT_OPCODE_OPER_SHR_UN = 0x01300000;

const JIT_OPCODE_OPER_COPY = 0x01400000;

const JIT_OPCODE_OPER_ADDRESS_OF = 0x01500000;







/*
 * Type kinds that may be returned by "jit_type_get_kind".
 */


const JIT_TYPE_INVALID = -1;

const JIT_TYPE_VOID = 0;

const JIT_TYPE_SBYTE = 1;

const JIT_TYPE_UBYTE = 2;

const JIT_TYPE_SHORT = 3;

const JIT_TYPE_USHORT = 4;

const JIT_TYPE_INT = 5;

const JIT_TYPE_UINT = 6;

const JIT_TYPE_NINT = 7;

const JIT_TYPE_NUINT = 8;

const JIT_TYPE_LONG = 9;

const JIT_TYPE_ULONG = 10;

const JIT_TYPE_FLOAT32 = 11;

const JIT_TYPE_FLOAT64 = 12;

const JIT_TYPE_NFLOAT = 13;

alias JIT_TYPE_NFLOAT JIT_TYPE_MAX_PRIMITIVE;

const JIT_TYPE_STRUCT = 14;

const JIT_TYPE_UNION = 15;

const JIT_TYPE_SIGNATURE = 16;

const JIT_TYPE_PTR = 17;

const JIT_TYPE_FIRST_TAGGED = 32;
/*
 * Special tag types.
 */


const JIT_TYPETAG_NAME = 10000;

const JIT_TYPETAG_STRUCT_NAME = 10001;

const JIT_TYPETAG_UNION_NAME = 10002;

const JIT_TYPETAG_ENUM_NAME = 10003;

const JIT_TYPETAG_CONST = 10004;

const JIT_TYPETAG_VOLATILE = 10005;

const JIT_TYPETAG_REFERENCE = 10006;

const JIT_TYPETAG_OUTPUT = 10007;

const JIT_TYPETAG_RESTRICT = 10008;

const JIT_TYPETAG_SYS_BOOL = 10009;

const JIT_TYPETAG_SYS_CHAR = 10010;

const JIT_TYPETAG_SYS_SCHAR = 10011;

const JIT_TYPETAG_SYS_UCHAR = 10012;

const JIT_TYPETAG_SYS_SHORT = 10013;

const JIT_TYPETAG_SYS_USHORT = 10014;

const JIT_TYPETAG_SYS_INT = 10015;

const JIT_TYPETAG_SYS_UINT = 10016;

const JIT_TYPETAG_SYS_LONG = 10017;

const JIT_TYPETAG_SYS_ULONG = 10018;

const JIT_TYPETAG_SYS_LONGLONG = 10019;

const JIT_TYPETAG_SYS_ULONGLONG = 10020;

const JIT_TYPETAG_SYS_FLOAT = 10021;

const JIT_TYPETAG_SYS_DOUBLE = 10022;

const JIT_TYPETAG_SYS_LONGDOUBLE = 10023;






const JIT_FAST_GET_CURRENT_FRAME = 0;


extern const jit_opcode_info_t [439]jit_opcodes;


/*
 * ABI types for function signatures.
 */








enum
{
    jit_abi_cdecl,
    jit_abi_vararg,
    jit_abi_stdcall,
    jit_abi_fastcall,
}
alias int jit_abi_t;




enum
{
    JIT_PROT_NONE,
    JIT_PROT_READ,
    JIT_PROT_READ_WRITE,
    JIT_PROT_EXEC_READ,
    JIT_PROT_EXEC_READ_WRITE,
}

alias int jit_prot_t;





