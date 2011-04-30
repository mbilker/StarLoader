__attribute__((constructor))
void thinload(){
if(CFBundleGetBundleWithIdentifier(CFSTR("com.skype.skype")!=NULL)
{
printf("STAR: we're on skype. Disabling Loader.");
return;
}
}

