IF NOT EXIST src.ain (
	COPY ..\Rance10.ain src.ain
)
IF NOT EXIST srcpact.afa (
	COPY ..\Rance10Pact.afa srcpact.afa
)

alice-tools\alice.exe project build Rance10.pje

pause
