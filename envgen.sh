cat > ~/.MacOSX/environment.plist << EOF
{
	"DYLD_INSERT_LIBRARIES" = "$HOME/.MacOSX/ThinLoader.dylib";
}
EOF
