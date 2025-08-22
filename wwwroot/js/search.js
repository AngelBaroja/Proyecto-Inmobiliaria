$(document).ready(function () {
    function filterTable() {
        var value = $('#searchInput').val().toLowerCase();
        $('tbody tr').each(function () {
            var rowText = $(this).find('td:not(:last-child)').text().toLowerCase();
            var match = rowText.indexOf(value) > -1;
            $(this).toggle(match);

            // Quitar resaltado anterior
            $(this).find('td').each(function () {
                var td = $(this);
                td.html(td.text());
            });

            // Resaltar coincidencias
            if (match && value.length > 0) {
                $(this).find('td:not(:last-child)').each(function () {
                    var td = $(this);
                    var regex = new RegExp('(' + value + ')', 'gi');
                    td.html(td.text().replace(regex, '<span class="bg-warning">$1</span>'));
                });
            }
        });
    }

    $('#searchInput').on('keyup', filterTable);

    $('#searchButton').click(filterTable);

    $('#searchInput').on('search', function () {
        filterTable();
    });
});