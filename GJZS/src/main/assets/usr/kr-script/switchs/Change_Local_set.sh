if [[ -f ~/offline ]]; then
	rm ~/offline
else
	touch ~/offline
	rm -r ~/Data_Dir
	rm -r ~/Configuration_File
	rm -r ~/kr-script
	rm -r ~/pages 
fi
am start -S $Package_name/com.projectkr.shell.SplashActivity