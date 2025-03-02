<?php require_once APPROOT . '/views/includes/header.php'; ?>

<h1><?= $data['title']; ?></h1>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Product Naam</th>
            <th>Aantal Geleverd</th>
            <th>Laatst Geleverd</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data['dataRows'] as $product): ?>
            <tr>
                <td><?= $product->product_naam; ?></td>
                <td><?= $product->aantal_in_magazijn; ?></td>
                <td><?= $product->laatst_geleverde_datum; ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<a href="<?= URLROOT; ?>/leveranciers/index">Terug naar Leveranciers</a>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>