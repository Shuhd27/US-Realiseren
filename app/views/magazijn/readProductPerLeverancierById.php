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
                        <th>Naam Leverancier:</th>
                        <td><?= $data['dataRows'][0]->LeverancierNaam; ?></td>
                    </tr>
                    <tr>
                        <th>Contactpersoon Leverancier:</th>
                        <td><?= $data['dataRows'][0]->Contactpersoon; ?></td>
                    </tr>
                    <tr>
                        <th>LeverancierNummer:</th>
                        <td><?= $data['dataRows'][0]->Leveranciernummer; ?></td>
                    </tr>
                    <tr>
                        <th>Mobiel:</th>
                        <td><?= $data['dataRows'][0]->Mobiel; ?></td>
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
                        <th>Naam Product</th>
                        <th>Datum Laatste Levering</th>
                        <th>Aantal</th>
                        <th>Eerstvolgende levering</th>
                    </thead>
                    <tbody>
                        <?php if ($data['dataRows'][0]->AantalAanwezig == 0) { 
                            header('Refresh: 4; ' . URLROOT . '/magazijn/index');?>
                            <tr>
                                <td colspan="4" class="text-center">
                                    Er is van dit product op dit moment geen voorraad aanwezig<br>
                                    de verwachte eerstvolgende levering is: 
                                    <?= date_format(date_create($data['dataRows'][array_key_last($data['dataRows'])]->DatumEerstVolgendeLevering), "d-m-Y"); ?>
                                </td>
                            </tr>
                        
                        <?php }  else { 

                         foreach( $data['dataRows'] as $info) { ?>
                            <tr>
                                <td><?= $info->ProductNaam ?></td>
                                <td><?= $info->DatumLevering ?></td>
                                <td><?= $info->Aantal ?></td>
                                <td><?= $info->DatumEerstVolgendeLevering ?></td>
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