// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get pageIdentificationEnterYourCode => 'Digite o código';

  @override
  String get pageIdentificationEnterTheCompanyCode =>
      'Digite o código da empresa\natribuído a você';

  @override
  String get pageLoginAskForLocationWhenInUsePermission =>
      'O aplicativo Lightdata coleta dados de localização para permitir o posicionamento de pacotes e o possível roteamento de entregas mesmo quando o aplicativo está fechado ou não está em uso.';

  @override
  String get pageLoginAskForLocationAlwaysPermission =>
      'Lightdata é um aplicativo que coletará a localização do celular em segundo plano para oferecer uma melhor ferramenta de trabalho. Dessa forma, a posição do pacote será conhecida em todos os momentos.';

  @override
  String get pageLoginAskForPermissions =>
      'O aplicativo Lightdata coleta dados de localização para:\n- Permitir o posicionamento de remessas e o roteamento de entregas.\n- Proporcionar uma ferramenta de trabalho melhor, rastreando a localização das remessas em tempo real.\n\nEsses dados são coletados mesmo quando o aplicativo está fechado ou não está em uso.(background)\n\nSaiba mais sobre como usamos seus dados de localização em nossa';

  @override
  String get pageLoginBadCredentials => 'Credenciais inválidas';

  @override
  String get pageLoginProCourrierError =>
      'Temos outro aplicativo para Pro Courrier, faça o download na Play Store';

  @override
  String get pageHomeTitle => 'Encomendas de ';

  @override
  String get pageHomeOptionShipmentsDeliveredToday =>
      'Pacotes a serem\n entregues hoje';

  @override
  String get pageHomeOptionTodaysAssignedShipments =>
      'Atribuir\npacotes de hoje';

  @override
  String get pageHomeOptionShipmentsOnTheWay => 'Pacotes\natribuídos';

  @override
  String get pageHomeOptionClosedShipments => 'Pacotes\ncerrados';

  @override
  String get pageHomeOptionPendingShipments => 'Pending\nshipments';

  @override
  String get pageHomeStartRoute => 'Iniciar rota';

  @override
  String get pageHomeFinishRoute => 'Finalizar rota';

  @override
  String get pageQrScanInvalidQR => 'QR inválido';

  @override
  String get pageQrMenuTitle => 'Selecione um leitor de QR';

  @override
  String get pageQrMenuOptionToProcessingPlant =>
      'Para a fábrica\n de processamento';

  @override
  String get pageQrMenuOptionCollect => 'Recolher';

  @override
  String get pageQrScanSuccess => 'Leitura QR realizada com sucesso';

  @override
  String get pageQrMenuOptionReadQr => 'Ler QR';

  @override
  String get pageQrMenuOptionAssign => 'Atribuir';

  @override
  String get pageQrMenuOptionCrossDocking => 'Cross Docking';

  @override
  String get pageQrMenuOptionShipmentInformation => 'Informações\n da remessa';

  @override
  String get pageQrMenuOptionEnterFlex => 'Inserir flex';

  @override
  String get pageQrCollectCollectedTodayByMe => 'Retirado hoje por mim';

  @override
  String get pageQrProccessingPlantTodayForMeInTheDay =>
      'Processando planta\nhoje para mim no dia';

  @override
  String get pageQrProccessingPlantCustomerToday => 'Cliente hoje';

  @override
  String pageQrProccessingPlantMissings(String clientName) {
    return 'Faltantes na planta de processamento hoje ($clientName)';
  }

  @override
  String get pageQrReadNow => 'Leia agora';

  @override
  String get pageQrScanTheQR => 'Leia o QR';

  @override
  String get pageQrDeliveryArea => 'Área de entrega';

  @override
  String get pageQrReadQRDni => 'Ler QR DNI';

  @override
  String get pageQrSaveVisit => 'Salvar visita';

  @override
  String get pageQrRegisterVisit => 'Registrar visita';

  @override
  String get pageQrSelfAssign => 'Autoatribuir';

  @override
  String get pageQrCollectTotalToCollectClient => 'Total a coletar do cliente';

  @override
  String get pageQrCollectToCollectToday => 'Para coletar hoje';

  @override
  String get pageQrCollectCollectedToday => 'Coletado hoje';

  @override
  String get pageFiltersApplyFilters => 'Aplicar filtros';

  @override
  String get pageFiltersCleanFilters => 'Limpar filtros';

  @override
  String get pageFiltersRecipientName => 'Nome do destinatário';

  @override
  String get pageFiltersClientName => 'Nome do cliente';

  @override
  String get pageShipmentProductsOrderedAmount => 'Quantidade encomendada';

  @override
  String get pageShipmentProductsLastReading => 'Última leitura';

  @override
  String get pageShipmentAssignmentAmountOfShipmentsAssignedToday =>
      'Remessas atribuídas hoje';

  @override
  String get pageShipmentAssignmentChooseADriver => 'Escolher um motorista';

  @override
  String get pageMapsGenerateRoutes => 'Gerar rotas';

  @override
  String get pageMapsGeolocate => 'Geolocalizar';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsGeolocated =>
      'Total de remessas geolocalizadas';

  @override
  String get pageMapsCardDataItemNumberOfShipmentsWithoutGeolocation =>
      'Total de remessas sem geolocalização';

  @override
  String get pageMapsCardDataItemDistanceInKm => 'Distância em quilômetros';

  @override
  String get pageMapsCardDataItemDistanceTime => 'Tempo de distância';

  @override
  String get pageMapsDepot => 'Depósito';

  @override
  String get pageMapsLastShipment => 'Última remessa';

  @override
  String get pageMapsMyCurrentLocation => 'Minha localização atual';

  @override
  String get pageMapsShipmentsWithoutGeolocate => 'Remessas sem geolocalização';

  @override
  String get pageMapsAlertYouHaveToSelectAShipment =>
      'Você precisa selecionar uma das remessas para gerar a rota.';

  @override
  String get pageMapsAvoidHighways => 'Evitar rodovias';

  @override
  String get pageMapsAvoidTollways => 'Evitar pedágios';

  @override
  String get pageMapsChooseWhereToFinish => 'Escolha onde terminar';

  @override
  String get pageMapsChooseWhereToStart => 'Escolha onde começar';

  @override
  String get pageMapsSelectALocation => 'Selecionar uma localização';

  @override
  String get pageMapsNoGeolocatedShipments => 'Nenhuma remessa geolocalizada';

  @override
  String get pageMapsRouteGeneratedCorrectly => 'Rota gerada corretamente';

  @override
  String get pageProfileForgetSession => 'Esquecer sessão';

  @override
  String get pageProfileProfilePicture => 'Foto do perfil';

  @override
  String get pageProfileDeletePictureConfirmation =>
      'Tem certeza de que deseja excluir esta foto?';

  @override
  String get pageProfileIntegrationsLinks => 'Links de integrações';

  @override
  String get pageProfileAreYouSureThatYouWantToDeleteCache =>
      'Tem certeza de que deseja excluir o cache?';

  @override
  String get pageProfileClearCache => 'Limpar cache';

  @override
  String get pageProfileProfilePictureChangedSuccessfully =>
      'Foto do perfil alterada com sucesso';

  @override
  String get pageProfileChangePassword => 'Alterar senha';

  @override
  String get pageProfileSuccessEditingPersonalData =>
      'Dados pessoais editados com sucesso';

  @override
  String get pageProfileChangeIcon => 'Alterar ícone';

  @override
  String get pageRegisterVisitAddObservations => 'Adicionar observações';

  @override
  String get pageRegisterVisitDNIOfTheRecipient => 'DNI do destinatário';

  @override
  String get pageRegisterVisitRUTOfTheRecipient => 'RUT do destinatário';

  @override
  String get pageRegisterVisitCCOfTheRecipient => 'C.C. do destinatário';

  @override
  String get pageRegisterVisitNameOfTheRecipient => 'Nome do destinatário';

  @override
  String get pageRegisterVisitRegisterVisit => 'Registrar visita';

  @override
  String get pageRegisterVisitImageLimitAlert =>
      'Você atingiu o limite de imagens';

  @override
  String get pageRegisterVisitSuccess => 'Visita registrada com sucesso';

  @override
  String get pageRegisterVisitUploadingImages => 'Carregando imagens...';

  @override
  String get pageRegisterVisitErrorRequiredImage =>
      'É necessário adicionar uma imagem';

  @override
  String get pageShipmentDetailsWithoutObservations => 'Sem observações';

  @override
  String get pageShipmentDetailsIdShipment => 'ID do envio';

  @override
  String get pageShipmentDetailsIdSale => 'ID da venda';

  @override
  String get pageShipmentDetailsTotalToClaim => 'Total a reclamar';

  @override
  String get pageShipmentDetailsWhoRecibeTheShipment =>
      'Package recipient is the buyer';

  @override
  String get pageShipmentDetailsNoLocationOfShipment =>
      'Sem localização do envio';

  @override
  String get pageShipmentListTotalShipments => 'Pacotes visualizados no total';

  @override
  String get pageShipmentListNoShipmentsAvailable => 'Nenhum envio disponível';

  @override
  String get pageShipmentListTheShipmentDoesntHavePhoneNumber =>
      'Este envio não possui um número de telefone atribuído.';

  @override
  String get pageShipmentListShipmentProximoAEntregar => 'Próximo a entregar';

  @override
  String get pageShipmentListTodaysPackagesAreNotBeingShown =>
      'Os pacotes de hoje não estão sendo mostrados';

  @override
  String get pageAccountsSellerId => 'ID do vendedor';

  @override
  String get pageSettlementsNoSettlements => 'Nenhum acordo disponível';

  @override
  String get pageSettlementsShipmentAddress => 'Endereço de envio';

  @override
  String get pageSettlementsWhoLiquidate => 'Quien liquido';

  @override
  String get pageSettlementsLiquidateDate => 'Fechada de liquidação';

  @override
  String get pageSettlementsNoShipmentAvailable => 'Nenhum envio disponível';

  @override
  String get pageSettlementsNumbersOfTrips => 'Número de viagens';

  @override
  String get pageAppConfiguration => 'Configuração do aplicativo';

  @override
  String get pageAppConfigurationDefaultRegisterVisitStates =>
      'Estados de visita padrão';

  @override
  String get pageAppConfigurationChangeGeoDriversHours =>
      'Alterar horas de geolocalização de motoristas';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursStartHour =>
      'Hora de início';

  @override
  String get pageAppConfigurationChangeGeoDriversHoursEndHour =>
      'Hora de término';

  @override
  String get pageAppConfigurationCheckPermissions => 'Verificar permissões';

  @override
  String get pageCheckPermissionsAlreadyAllowed =>
      'As permissões já foram concedidas';

  @override
  String get pageCheckPermissionsAlreadyAllowedDescription =>
      'As permissões já foram concedidas';

  @override
  String get pageAppConfigurationCheckPermissionsAllowed =>
      'Permissões permitidas';

  @override
  String get pageCheckPermissionsAllowedDescription =>
      'As permissões foram concedidas';

  @override
  String get pageAppConfigurationCheckPermissionsDenied => 'Permissões negadas';

  @override
  String get pageAppConfigurationNewWhatsappMessages =>
      'Novas mensagens do WhatsApp disponíveis';

  @override
  String get pageCollectCurrentRoute => 'Rota atual';

  @override
  String get pageCollectToCollect => 'Coletar';

  @override
  String get pageCollectCollectList => 'Lista de coletas';

  @override
  String get pageCollectSettlementList => 'Lista de acordos';

  @override
  String get pageCollectShipmentList => 'Lista de envios';

  @override
  String get pageCollectCollectDetails => 'Detalhes da coleta';

  @override
  String get pageCollectSellerDetails => 'Detalhes do vendedor';

  @override
  String get pageCollectSettlementDate => 'Data de liquidação';

  @override
  String get pageCollectSettlementRange => 'Intervalo de liquidação';

  @override
  String get pageCollectSettlementDetails => 'Detalhes da liquidação';

  @override
  String get pageCollectTotalToCollect => 'Total a coletar';

  @override
  String get pageCollectTotalClients => 'Total de clientes';

  @override
  String get pageCollectTotalClientsToCollect => 'Total de clientes a coletar';

  @override
  String get pageCollectNotEveryClientIsGeolocalized =>
      'Nem todos os clientes estão geolocalizados';

  @override
  String get bottomNavigationBarOptionHome => 'Início';

  @override
  String get bottomNavigationBarOptionShipments => 'Envios';

  @override
  String get bottomNavigationBarOptionQR => 'QR';

  @override
  String get bottomNavigationBarOptionMaps => 'Mapas';

  @override
  String get bottomNavigationBarOptionProfile => 'Perfil';

  @override
  String get bottomNavigationBarOptionSettings => 'Configurações';

  @override
  String get bottomNavigationBarOptionMySettlements => 'Meus acordos';

  @override
  String get bottomNavigationBarOptionLogout => 'Sair';

  @override
  String get stateCollected => 'Coletado';

  @override
  String get stateAtProcessingPlant => 'Na planta de processamento';

  @override
  String get stateAtProcessingPlant2 => 'Na planta de processamento 2';

  @override
  String get stateOnTheWay => 'A caminho';

  @override
  String get stateReturningToProcessingPlant =>
      'Retornando à planta de processamento';

  @override
  String get stateDelivered => 'Entregue';

  @override
  String get stateNobody => 'Ninguém';

  @override
  String get stateToBeCollected => 'A ser coletado';

  @override
  String get stateCanceled => 'Cancelado';

  @override
  String get stateDeliveredSecondVisit => 'Entregue segunda visita';

  @override
  String get stateNobodySecondVisit => 'Ninguém segunda visita';

  @override
  String get stateOnTheWaySecondVisit => 'A caminho segunda visita';

  @override
  String get stateOnTheWayRescheduled => 'A caminho reagendado';

  @override
  String get stateNotDelivered => 'Não entregue';

  @override
  String get stateReturnedToClient => 'Devolvido ao cliente';

  @override
  String get stateRejectedByClient => 'Rejeitado pelo cliente';

  @override
  String get stateOnTheWayThirdVisit => 'A caminho terceira visita';

  @override
  String get stateDeliveredThirdVisit => 'Entregue terceira visita';

  @override
  String get stateNobodyThirdVisit => 'Ninguém terceira visita';

  @override
  String get stateDeliveredPickupPoint => 'Entregue ponto de coleta';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get commonUser => 'Usuário';

  @override
  String get commonFilter => 'Filtro';

  @override
  String get commonLogin => 'Login';

  @override
  String get commonToday => 'Hoje';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonGenerate => 'Gerar';

  @override
  String get commonId => 'ID';

  @override
  String get commonUbication => 'Localização';

  @override
  String get commonSaveImage => 'Salvar imagem';

  @override
  String get commonAddImage => 'Adicionar imagem';

  @override
  String get commonDeleteImage => 'Excluir imagem';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonUserName => 'Nome de usuário';

  @override
  String get commonContact => 'Contato';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonCompany => 'Empresa';

  @override
  String get commonPlan => 'Plan';

  @override
  String get commonAccept => 'Aceitar';

  @override
  String get commonDriver => 'Motorista';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonLoad => 'Carregar';

  @override
  String get commonHome => 'Início';

  @override
  String get commonCamera => 'Câmera';

  @override
  String get commonGallery => 'Galeria';

  @override
  String get commonHistory => 'Histórico';

  @override
  String get commonState => 'Estado';

  @override
  String get commonStates => 'Estados';

  @override
  String get commonLocation => 'Localização';

  @override
  String get commonAddress => 'Endereço';

  @override
  String get commonDate => 'Data';

  @override
  String get commonDateFrom => 'Data inicial';

  @override
  String get commonDateTo => 'Data final';

  @override
  String get commonObservations => 'Observações';

  @override
  String get commonClient => 'Cliente';

  @override
  String get commonTotal => 'Total';

  @override
  String get commonTracking => 'Rastreamento';

  @override
  String get commonSettlements => 'Acordos';

  @override
  String get commonSelectADate => 'Selecione uma data';

  @override
  String get commonPersonalData => 'Dados pessoais';

  @override
  String get commonMyData => 'Meus dados';

  @override
  String get commonOn => 'Ativado';

  @override
  String get commonOff => 'Desativado';

  @override
  String get commonAssign => 'Atribuir';

  @override
  String get commonSKU => 'SKU';

  @override
  String get commonVariation => 'Variação';

  @override
  String get commonSource => 'Fonte';

  @override
  String get commonImportant => 'Importante';

  @override
  String get commonIncorrectCode => 'Código incorreto';

  @override
  String get commonBack => 'Voltar';

  @override
  String get commonHouse => 'Casa';

  @override
  String get commonSelect => 'Selecionar';

  @override
  String get commonSync => 'Sincronizar';

  @override
  String get commonWithoutSync => 'Não sincronizado';

  @override
  String get commonNumber => 'Número';

  @override
  String get commonAdd => 'Adicionar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSaved => 'Salvo';

  @override
  String get commonFeatNotAvailableTitle => 'Recurso não disponível';

  @override
  String get commonFeatNotAvailableDescription =>
      'Este recurso não está disponível nesta versão do aplicativo.';

  @override
  String get commonInformationSavedSuccessfully =>
      'Suas informações foram salvas com sucesso';

  @override
  String get commonOops => 'Ops';

  @override
  String get commonNoMovements => 'Sem movimentos para mostrar';

  @override
  String get commonCP => 'CEP';

  @override
  String get commonAccounts => 'Contas';

  @override
  String get commonHi => 'Olá';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonOk => 'Ok';

  @override
  String get commonAdmitted => 'Admitido';

  @override
  String get commonSeconds => 'Segundos';

  @override
  String get commonError => 'Erro';

  @override
  String get commonIUnderstand => 'Eu entendo';

  @override
  String get commonPassword => 'Senha';

  @override
  String get commonOf => 'de';

  @override
  String get commonNoInternet => 'Sem conexão com a internet';

  @override
  String get commonNoAvailableWithoutInternet =>
      'Este recurso não está disponível sem uma conexão com a internet.';

  @override
  String get commonErrorText =>
      'Ocorreu um erro, tente excluir o cache e fazer login novamente. Se o problema persistir, entre em contato com o suporte.';

  @override
  String get commonShipment => 'Remessa';

  @override
  String get commonVersion => 'Versão';

  @override
  String get commonApp => 'App';

  @override
  String get commonCurrentPassword => 'Senha atual';

  @override
  String get commonNewPassword => 'Nova senha';

  @override
  String get commonRepeatNewPassword => 'Repetir nova senha';

  @override
  String get commonSuccess => 'Sucesso';

  @override
  String get commonChange => 'Alterar';

  @override
  String get commonBranch => 'Filial';

  @override
  String get commonNow => 'Agora';

  @override
  String get commonNotifications => 'Notificações';

  @override
  String get commonCollect => 'Coletar';

  @override
  String get commonStart => 'Iniciar';

  @override
  String get commonSavedWithoutConnection => 'Salvo sem conexão';

  @override
  String get commonRefresh => 'Atualizar';

  @override
  String get commonUnAssign => 'Desatribuir';

  @override
  String commonSynchronizing(int current, int total) {
    return 'Sincronizando $current de $total';
  }

  @override
  String get commonWhitoutInformation => 'Sem informações';

  @override
  String get commonRegenerate => 'Regenerar';

  @override
  String get commonNoShipmentsAvailable => 'Nenhum envio disponível';

  @override
  String get commonAmountToCharge => 'Valor a ser cobrado';

  @override
  String get commonAllowPermissions => 'Permitir permissões';
}
