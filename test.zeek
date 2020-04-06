global iptAg: table[addr] of set[string];
event http_all_headers(c: connection, is_orig: bool, hlist: mime_header_list)
{
local x: set[string];
local uA:string;
	if(hlist[2]$name=="USER-AGENT")
	{
		uA=hlist[2]$value;
		if(c$id$orig_h in iptAg)
		{
			x=iptAg[c$id$orig_h];
			add x[uA];
			iptAg[c$id$orig_h]=x;
		}else
		{
			add x[uA];
			iptAg[c$id$orig_h]=x;
		}
	}
	if(|iptAg[c$id$orig_h]|>=3)
	{
	print c$id$orig_h," is a proxy";
	}
}
