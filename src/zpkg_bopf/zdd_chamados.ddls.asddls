@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data from ZRICKT_CHAMADO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.compositionRoot: true
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.writeActivePersistence: 'zrickt_chamado'
@ObjectModel.semanticKey: [ 'Chamadoid' ]
@ObjectModel.alternativeKey: [ { element: ['chamadoid'], uniqueness: #UNIQUE_IF_NOT_INITIAL, id: 'Chamadoid' } ]
define view entity ZDD_CHAMADOS as select from zrickt_chamado
{
    key chamadoid as Chamadoid,
    assunto as Assunto,
    descricao as Descricao,
    solicianteid as Solicianteid,
    status as Status
}
