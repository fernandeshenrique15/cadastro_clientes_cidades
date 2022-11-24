import 'package:flutter/material.dart';

class Components {
  createAppBar(titulo, tam, cor, acao) {
    return AppBar(
      title: createText(titulo, tam, cor),
      iconTheme: IconThemeData(color: cor),
      centerTitle: true,
      actions: [
        if (acao != null)
          IconButton(onPressed: acao, icon: const Icon(Icons.home))
      ],
    );
  }

  createText(conteudo, tamanho, cor) {
    return Text(
      conteudo,
      style: TextStyle(fontSize: tamanho, color: cor),
    );
  }

  createTextField(
      titulo, ofuscar, tipoTeclado, controlador, msgValidacao, context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controlador,
        keyboardType: tipoTeclado,
        obscureText: ofuscar,
        decoration: InputDecoration(
            labelText: titulo,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2.0,
              ),
            ),
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        validator: (value) {
          if (value!.isEmpty) {
            return msgValidacao;
          }
        },
      ),
    );
  }

  createButtonRedirect(
      rotulo, funcao, page, controladorForm, context, tamanho) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: tamanho,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary)),
              onPressed: () {
                funcao(page);
              },
              child: createText(
                  rotulo, 20, Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
      ],
    );
  }

  createButton(rotulo, funcao, controladorForm, context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary)),
          onPressed: () {
            if (controladorForm.currentState!.validate()) {
              funcao();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                createText(rotulo, 20, Theme.of(context).colorScheme.onSurface),
          ),
        ));
  }
}
