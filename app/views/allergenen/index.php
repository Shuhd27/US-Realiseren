<?php require_once APPROOT . '/views/includes/header.php'; ?>

<div class="container">
    <h1><?= $data['title']; ?></h1>

    <!-- ✅ Foutmelding tonen als er geen data is -->
    <?php if (!empty($data['message'])): ?>
        <div class="alert alert-<?= $data['messageColor']; ?>" style="display: <?= $data['messageVisibility']; ?>">
            <?= $data['message']; ?>
        </div>
    <?php endif; ?>

    <?php if (!empty($data['allergenen'])): ?>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Productnaam</th>
                    <th>Barcode</th>
                    <th>Allergeen</th>
                    <th>Omschrijving</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($data['allergenen'] as $row): ?>
                    <tr>
                        <td><?= $row->ProductNaam; ?></td>
                        <td><?= $row->Barcode; ?></td>
                        <td><?= $row->AllergeenNaam; ?></td>
                        <td><?= $row->Omschrijving; ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p class="text-danger">Geen allergenen gevonden!</p>
    <?php endif; ?>
</div>
 <pre>
    <?php print_r($data); ?>
 </pre>
<?php require_once APPROOT . '/views/includes/footer.php';?>