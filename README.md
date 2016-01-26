# Tests Ports Between Devices


* Test-PortConnectivity -Source '127.0.0.1' -RemoteDestination 'dc1' -Port 57766
* Test-PortConnectivity '127.0.0.1' 'dc1' 57766 -Protocol UDP -Iterate
* Test-PortConnectivity 'localhost' 'dc2' 51753 -Protocol UDP
* Test-PortConnectivity -Source $EUCAS -RemoteDestination $EUMBX -Port 135 -Iterate
* Test-PortConnectivity -Source 'localhost' -RemoteDestination '127.0.0.1' -Port 135 -Iterate -protocol TCP

<img src="http://gitlab/Technology-Management/Test-PortConnectivity/raw/master/Resources/Capture.PNG">