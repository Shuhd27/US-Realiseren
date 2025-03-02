<?php require_once APPROOT . '/views/includes/header.php'; ?>

<h1><?= $data['title']; ?></h1>

<?php if ($data['leverancier']): ?>
    <p>Naam: <?= $data['leverancier']->LeverancierNaam; ?></p>
    <p>Contactpersoon: <?= $data['leverancier']->Contactpersoon; ?></p>
    <p>Leveranciernummer: <?= $data['leverancier']->Leveranciernummer; ?></p>
    <p>Mobiel: <?= $data['leverancier']->Mobiel; ?></p>
<?php else: ?>
    <p>Er zijn geen gegevens beschikbaar.</p>
<?php endif; ?>

<a href="<?= URLROOT; ?>/allergenen/index">Terug naar allergenen overzicht</a>

<?php require_once APPROOT . '/views/includes/footer.php'; ?>