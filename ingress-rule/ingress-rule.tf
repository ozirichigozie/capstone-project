resource "kubernetes_ingress_v1" "micro-ingress" {
  metadata {
    name      = "e-commerce"
    namespace = "e-commerce"
    labels = {
      name = "front-end"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
  }

  spec {
    rule {
      host = "capstone.cloudbusters.space"
      http {
        path {
          backend {
            service {
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

