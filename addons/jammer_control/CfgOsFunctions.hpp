// The terminal command "jammer" of AE3 laptops. AE3 installs every class of CfgOsFunctions that inherits from
// OsFunction on every laptop (AE3_armaos_fnc_link_init), so it also works over SSH. AE3 does not allow [] in these
// strings
class OsFunction;

class CfgOsFunctions {
    class jammer: OsFunction {
        path = "/usr/bin/jammer";
        description = CSTRING(os_description);
        man = CSTRING(os_man);
        code = QUOTE(call FUNC(osJammer));
    };
};
