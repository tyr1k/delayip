<!DOCTYPE html>
<html>
<head>
    <title>Script to delay network traffic to a specific IP address</title>
</head>
<body>
    <h1>Script to delay network traffic to a specific IP address</h1>
    <p>This script sets a delay on network traffic to a specific IP address using the tc command in Linux.</p>
    <h2>Usage</h2>
    <pre>$ ./delay_ip.sh &lt;interface&gt; &lt;ip-address&gt; &lt;delay&gt;</pre>
    <p>Example:</p>
    <pre>$ ./delay_ip.sh eth0 192.168.1.1 10ms</pre>
    <p>Use the <code>--off</code> or <code>-o</code> option to reset the delay:</p>
    <pre>$ ./delay_ip.sh --off</pre>
    <h2>Arguments</h2>
    <ul>
        <li><code>interface</code>: The network interface name to apply the delay to</li>
        <li><code>ip-address</code>: The IP address to apply the delay to</li>
        <li><code>delay</code>: The delay time to apply to the traffic (in ms or s)</li>
    </ul>
    <h2>Requirements</h2>
    <p>This script requires the tc command to be installed on the Linux system.</p>
    <h2>License</h2>
    <p>This script is released under the MIT License.</p>
</body>
</html>
