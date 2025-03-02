<?php require_once APPROOT . '/views/includes/header.php'; ?>


<!-- Voor het centreren van de container gebruiken we het boodstrap grid -->
<div class="container">

    <div class="row mt-3 text-center" style="display:<?= $data['messageVisibility']; ?>">
        <div class="col-2"></div>
        <div class="col-8">
            <div class="alert alert-<?= $data['messageColor']; ?>" role="alert">
                <?= $data['message']; ?>
            </div>
        </div>
        <div class="col-2"></div>
    </div>


    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <h3><?php echo $data['title']; ?></h3>
        </div>
        <div class="col-2"></div>
    </div>

    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-4">
            <table class="table table-hover">
                <tbody>
                    <tr>
                        <th>Naam:</th>
                        <td><?= $data['dataRows'][0]->ProductNaam; ?></td>
                    </tr>
                    <tr>
                        <th>Barcode:</th>
                        <td><?= $data['dataRows'][0]->Barcode; ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="col-6"></div>
    </div>

    <div class="row mt-3">
        <div class="col-2"></div>
        <div class="col-8">
            <table class="table table-hover">
                    <thead>
                        <th>Naam</th>
                        <th>Omschrijving</th>
                    </thead>
                    <tbody>
                        <?php if (is_null($data['dataRows'][0]->AllergeenNaam)) { 
                            header('Refresh: 4; ' . URLROOT . '/magazijn/index');?>
                            <tr>
                                <td colspan="4" class="text-center text-danger">
                                In dit product zitten geen stoffen die een allergische reactie kunnen veroorzaken
                                </td>
                            </tr>
                        
                        <?php }  else { 

                         foreach( $data['dataRows'] as $info) { ?>
                            <tr>
                                <td><?= $info->AllergeenNaam ?></td>
                                <td><?= $info->Omschrijving ?></td>
                            </tr>
                        <?php }
                        } ?>
                    </tbody>
                </table>
            
                <a href="<?= URLROOT; ?>/magazijn/index"><h3><i class="bi bi-arrow-left-square-fill"></i></h3></a>
        </div>
        <div class="col-2"></div>
    </div>

</div>




<?php require_once APPROOT . '/views/includes/footer.php'; ?>