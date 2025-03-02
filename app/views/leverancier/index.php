<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  </head>
  <body>
    
    <div class="container mt-3">

        <div class="row mt-3 text-center" style="display:<?= $data['messageVisibility'] ?? 'none'; ?>">
            <div class="col-2"></div>
            <div class="col-8">
                <div class="alert alert-<?= $data['messageColor']; ?>" role="alert">
                    <?= $data['message']; ?>
                </div>
            </div>
            <div class="col-2"></div>
        </div>
        
        <div class="row">
            <div class="col-2"></div>
            <div class="col-8">
                <h3 class="text-primary"><u>Overzicht Leveranciers</u></h3>
            </div>
            <div class="col-2"></div>
        </div>

        <div class="row">
          <div class="col-2"></div>
          <div class="col-8">
            <table class="table table-striped table-hover">
              <thead>
                <th>Naam</th>
                <th>Contactpersoon</th>
                <th>Leveranciernummer</th>
                <th>Mobiel</th>
                <th>Aantal producten</th>
                <th>Toon producten</th>
              </thead>
              <tbody>
                  <?php if (is_null($data['dataRows'])) : ?>
                      <tr>
                        <td colspan='6' class='text-center'>Door een storing kunnen we op dit moment geen leveranciers tonen</td>
                      </tr>
                  <?php else :
                          foreach ($data['dataRows'] as $row) : ?>
                            <tr>
                              <td><?= $row->Naam; ?></td>
                              <td><?= $row->Contactpersoon; ?></td>
                              <td><?= $row->LeverancierNummer; ?></td>
                              <td><?= $row->Mobiel; ?></td>
                              <td class="text-center"><?= $row->AantalProducten; ?></td>
                              <td class="text-center text-primary">
                                  <a href="<?= URLROOT; ?>/leveranciers/geleverdeproducten/<?= $row->LeverancierId; ?>">
                                      <i class="bi bi-box-fill"></i>
                                  </a>                      
                              </td>
                            </tr>
                    <?php endforeach;
                        endif ?>
              </tbody>
            </table>
          </div>
          <div class="col-2"></div>
        </div>

        <div class="row">
          <div class="col-2"></div>
          <div class="col-2">
              <a href="<?= URLROOT; ?>/homepages/index"><h4><i class="bi bi-arrow-left-square-fill"></i></h4></a>
          </div>
          <div class="col-10"></div>
        </div>





    </div>




    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  </body>
</html>