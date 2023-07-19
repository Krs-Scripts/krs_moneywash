$(window).ready(function () {
    $('#container').hide();
    $('#safe').hide();
    $('#info').hide();

    document.addEventListener("keydown", function (event) {
        if (event.key == 'Escape') {
            var popuprev = new Audio('popupreverse.mp3');
            popuprev.volume = 0.5;
            popuprev.play();
            close();
        }
    });

    function close() {
        $('#container').hide();
        $('#safe').hide();

        // Make sure to handle potential errors during fetch
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            }
        })
            .then(resp => resp.json())
            .then(resp => console.log(resp))
            .catch(error => {
                // Non utilizzare 'error' nell'ambito del blocco catch.
                //console.error('Error occurred during fetch:', error); // You can omit this line or do specific error handling
            });
    }

    window.addEventListener('message', function (event) {
        let data = event.data;

        if (data.action == 'info') {
            $('#info').show();
        }

        if (data.action == 'closeinfo') {
            $('#info').hide();
        }

        if (data.action == 'open') {
            var popup = new Audio('popup.mp3');
            popup.volume = 0.5;
            popup.play();
            $('#info').hide();

            document.getElementById('titolo1').innerText = data.notify.titolo1;
            document.getElementById('secline').innerText = data.notify.titolo2;
            document.getElementById('soldisporchi').innerText = data.notify.soldisporchi;
            document.getElementById('soldipuliti').innerText = data.notify.soldipuliti;
            document.getElementById('lavaggiosoldi').innerText = data.notify.washmoney;

            $('#container').show();

            $('#lavaggiosoldi').click(function (event) {
                $('#container').hide();
                $('#safe').show();

                document.getElementById('safeaccetta').innerText = data.notify.accetta;
                document.getElementById('safeannulla').innerText = data.notify.annulla;

                $('#safeaccetta').click(function (event) {
                    close();

                    // Make sure to handle potential errors during fetch
                    fetch(`https://${GetParentResourceName()}/WashBlackMoney`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json; charset=UTF-8'
                        }
                    })
                        .then(resp => resp.json())
                        .then(resp => console.log(resp))
                        .catch(error => {
                            // Non utilizzare 'error' nell'ambito del blocco catch.
                            //console.error('Error occurred during fetch:', error); // You can omit this line or do specific error handling
                        });
                });

                $('#safeannulla').click(function (event) {
                    close();
                });
            });

            document.getElementById('blackmoney').innerText = data.blackcash + ` ${data.currency}`;

            let endmoney = data.blackcash * ((100 - data.removecash) / 100);
            document.getElementById('green').innerText = endmoney + ` ${data.currency}`;

            document.getElementById('safetext').innerText = `Are you sure you want to wash your money? ${data.blackcash}${data.currency} ${data.removecash}%`;
        }
    });
});
