<?php require_once APPROOT . '/views/includes/header.php'; ?>

<!-- Voor het centreren van de container gebruiken we het boorstrap grid -->
<div class="container">
    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <h3><?php echo $data['title']; ?></h3>

            <!-- <a href="<?= URLROOT; ?>/instructeurs/index">Instructeurs</a> | -->
            <!-- <a href="<?= URLROOT; ?>/countries/index">Landen van de Wereld</a> | -->
            <a href="<?= URLROOT; ?>/magazijn/index">Overzicht magazijn Jamin</a> |
            <a href="<?= URLROOT; ?>/allergenen/index">Overzicht Allergenen</a> |
            <a href="<?= URLROOT; ?>/leveranciers/index">Overzicht Leveranciers</a> 
            <!-- <a href="<?= URLROOT; ?>/leverancier/index">Overzicht leverancier Jamin</a> | -->

        </div>
        <div class="col-2"></div>
    </div>

</div>




<?php require_once APPROOT . '/views/includes/footer.php'; ?>