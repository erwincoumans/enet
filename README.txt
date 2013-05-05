enet NAT punchthrough test

MIT License

BUILD instructions

Windows: click on build/vs2010.bat and build the solution in build/vs2010
Linux: in a terminal, cd build, ./premake_linux gmake, cd gmake, make
Mac OSX: same as Linux or click on build/xcode4.command and open build/xcode4 using Xcode

Usage:

Run the server, located in the bin folder (Test_enet_server*)
Run the client twice, located in the bin folder (Test_enet_client*)

The server will exchange the addresses and the clients will directly connect to eachother and send messages

See also the discussion here:
http://lists.cubik.org/pipermail/enet-discuss/2013-May/thread.html#2163

