
function setCountDown(date) {
    let countDownDate = new Date(date).getTime();
    let x = setInterval(function() {

        let now = new Date().getTime();

        let distance = countDownDate - now;

        let days = Math.floor(distance / (1000 * 60 * 60 * 24));
        let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((distance % (1000 * 60)) / 1000);

        let timer = document.getElementById("timer");
        if (timer != null) {
            timer.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";
            if (distance < 0) {
                clearInterval(x);
                location.reload();
            }
        } else {
            clearInterval(x);
        }
    }, 1000);
}
