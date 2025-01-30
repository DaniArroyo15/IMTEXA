var gUpLoad;
window.onload = function () {
    _Load.Close();
    _Usuario = sessionStorage.getItem("JUsuario").split(_sepFields);
    _Area = "Almacen"
    _Controller = "Producto"
    _Url = _Area + "/" + _Controller + "/";
    CargaCombo();
    setEvents();
}

function setEvents() {
    cboCategoria.onchange = function () {
        ListaProducto();
    }
}

function CargaCombo() {
    Http.get(_Url + "ListaCategoria", muestraCategoria);

}

function muestraCategoria(rpta) {
    if (rpta) {
        var ListCate = rpta.split(_sepRows);
        UI.Combo(cboCategoria, ListCate, 0);

        cboCategoria.selectedIndex = 0;

        var event = new Event('change');
        cboCategoria.dispatchEvent(event);
    }
}

function ListaProducto() {

    var iCategoria = cboCategoria.value === "" ? "1" : cboCategoria.value;
    Http.get(_Url + "ListaProducto?CategoriaId=" + iCategoria, mostrarLista);
}

function mostrarLista(rpta) {
    if (rpta) {
        var Lista = rpta.split(_sepTables);
        var ListaTab = Lista[0].split(_sepRows);

        var opts = {
            Id: _Controller,
            DataTable: ListaTab,
            RowsForPage: 10,
            ReportTitle: "Lista Producto",
            HasEdit: true,
            HasDelete: true,
            ColorIndex: [{
                index: 8,
                condition: `DISPONIBLE|${_Estados.Aprobado}^VENDIDO|${_Estados.Rechazado}`
            }],
            HasExport: true,
            Import: { Enabled: true, Function: 'Importar' }
        }
        UI.Grid(divProducto, opts);

        gUpLoad = document.getElementById("upFile" + _Controller);
    }
}

function Importar() {

    gUpLoad.click();

    gUpLoad.onchange = function () {
        file = this.files[0];
        var frm = new FormData();
        frm.append("file", file);
        Http.post("General/Importar?pTabla=" + _Controller, GetGrabarFile, frm);
    }
}

function GetGrabarFile(rpta) {
    if (rpta) {
        var list = rpta.split(_sepTables);
        var listProduct = list[2];
        mostrarLista(listProduct);
        Notify.Show('s', 'Data importada');
    }
}

