const SERVER_URL = 'ws://192.168.1.6:8080';
const ws = new WebSocket(SERVER_URL);
const logs = document.querySelector('#logs');

ws.onopen = () => {
    const p = document.createElement("p");
    p.innerHTML = "Connected!"
    logs.appendChild(p)
};

ws.onmessage = (event) => {
    const p = document.createElement("p");
    p.innerHTML = `received: ${event.data}`;
    logs.appendChild(p);
};

function sendMessage() {
    const input = document.querySelector('#message');
    const message = input.value;
    const p = document.createElement("p");

    ws.send(message);
    p.innerHTML = `sent: ${message}`;
    logs.appendChild(p);
    input.value = '';
}
