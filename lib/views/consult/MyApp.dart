/* Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _listadoPublicaciones,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: _listPublicaciones(snapshot.data, context),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _listadoPublicaciones,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: _listPublicaciones(snapshot.data, context),
                      );
                    }
                  },
                ),
              ),
              Text('Hello wordl'),
            ],
          )

          */
