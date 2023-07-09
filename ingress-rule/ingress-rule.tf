resource "kubernetes_ingress_v1" "micro-ingress" {
  metadata {
    name      = "lakesidemutual"
    namespace = "lakesidemutual"
    labels = {
      name = "front-end"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
  }

  spec {
    rule {
      host = "lakesidemutual.cloudbusters.space"
      http {
        path {
          backend {
            service{
              name = "front-end"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

