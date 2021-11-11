IF NOT EXIST src.ain (
	COPY ..\Rance10.ain src.ain
)

alice-tools\alice.exe project build Rance10.pje

pause
