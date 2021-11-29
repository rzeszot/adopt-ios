public struct Input {
  public typealias Block = () -> Void

  let remind: Block?

  public init(remind: Block? = nil) {
    self.remind = remind
  }
}
